/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZJSONRequest.h"
#import "ZZDebug.h"
#import "SBJson.h"
#import "NSData+Base64.h"

NSURLRequestCachePolicy ZZURLRequestCachePolicy = NSURLRequestUseProtocolCachePolicy;
//NSURLCacheStoragePolicy ZZURLCacheStoragePolicy = NSURLCacheStorageAllowedInMemoryOnly;

@implementation ZZJSONRequest

@synthesize connection = _connection;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithDelegate:(id<ZZJSONRequestDelegate>)delegate {
    self = [super init];
	if (self) {
		_delegate = delegate;
	}
	return self;
}

- (void)get:(NSString*)urlstr {
    [self cancel];
    self.urlString = urlstr;
    
    NSURL* url = [NSURL URLWithString:_urlString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:ZZURLRequestCachePolicy
                                                       timeoutInterval:20];
    if ([self.username length] && [self.password length]) {
        [self authForRequest:request];
    }
    _loaded = NO;
    _loading = YES;
    
    _data = [[NSMutableData alloc] init];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)post:(NSString *)urlstr params:(NSDictionary *)params
{
    [self send:urlstr params:params method:@"POST"];
}

- (void)put:(NSString *)urlstr params:(NSDictionary *)params
{
    [self send:urlstr params:params method:@"PUT"];
}

- (void)send:(NSString *)urlstr params:(NSDictionary *)params method:(NSString*)method
{
    [self cancel];
    self.urlString = urlstr;
    
    NSURL* url = [NSURL URLWithString:_urlString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:ZZURLRequestCachePolicy
                                                       timeoutInterval:20];
    request.HTTPMethod = method;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    SBJsonWriter* writer = [[SBJsonWriter alloc] init];
    NSString* json = [writer stringWithObject:params];
    ZZLOG(@"json to post: %@", json);
    
    NSData* postData = [NSData dataWithBytes:[json UTF8String] length:[json length]];
    [request setValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: postData];
    
    if ([self.username length] && [self.password length]) {
        [self authForRequest:request];
    }
    _loaded = NO;
    _loading = YES;
    
    _data = [[NSMutableData alloc] init];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    _delegate = nil;
	[self cancel];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)cancel {
	_loaded = _loading = NO;
	[_connection cancel];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - NSURLConnection delegate
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	ZZLOG(@"get response from %@", _urlString);
	[_data setLength:0];
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    _status = [httpResponse statusCode];
    ZZLOG(@"response status: %d", _status);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	ZZLOG(@"got %d bytes", [data length]);
	[_data appendData:data];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	ZZLOG(@"finish loading successfuly");
	_loaded = YES;
	_loading = NO;

	// parse data
	self.responseString = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
	ZZLOG(@"json: %@", self.responseString);
    
    SBJsonParser* parser = [[SBJsonParser alloc] init];
    _response = [parser objectWithString:self.responseString];
	
	if ([_delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
		[_delegate requestDidFinishLoading:self];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    ZZLOG(@"connection failed with error: %@", [error localizedDescription]);
	_loaded = _loading = NO;
	if ([_delegate respondsToSelector:@selector(request:failedWithError:)]) {
		[_delegate request:self failedWithError:error];
	}
}

- (void)authUsername:(NSString *)username password:(NSString *)password
{
    self.username = username;
    self.password = password;
}

- (void)authForRequest:(NSMutableURLRequest*)request
{
    NSString *authStr = [NSString stringWithFormat:@"%@:%@", self.username, self.password];
    NSData *authData = [authStr dataUsingEncoding:NSASCIIStringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64EncodingWithLineLength:80]];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
}

@end
