/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZJSONRequest.h"
#import "ZZDebug.h"
#import "SBJson.h"
#import "NSData+Base64.h"

NSURLRequestCachePolicy ZZURLRequestCachePolicy = NSURLRequestUseProtocolCachePolicy;
//NSURLCacheStoragePolicy ZZURLCacheStoragePolicy = NSURLCacheStorageAllowedInMemoryOnly;

static NSDictionary* persistentHeaders;

@implementation ZZJSONRequest

@synthesize connection = _connection;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithDelegate:(id<ZZJSONRequestDelegate>)delegate {
    self = [super init];
	if (self) {
		_delegate = delegate;
        _debug = NO;
	}
	return self;
}

- (void)_get:(NSString*)urlstr method:(NSString*)method {
    [self cancel];
    self.urlString = urlstr;
    
    NSURL* url = [NSURL URLWithString:_urlString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:ZZURLRequestCachePolicy
                                                       timeoutInterval:20];
    request.HTTPMethod = method;
    
    // set persistent headers
    for (NSString* key in [persistentHeaders allKeys]) {
        [request setValue:persistentHeaders[key] forHTTPHeaderField:key];
    }
    
    if ([self.username length] && [self.password length]) {
        [self authForRequest:request];
    }
    _loaded = NO;
    _loading = YES;
    
    _data = [[NSMutableData alloc] init];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)get:(NSString*)urlstr
{
    [self _get:urlstr method:@"GET"];
}

- (void)del:(NSString *)urlstr
{
    [self _get:urlstr method:@"DELETE"];
}

- (void)post:(NSString *)urlstr params:(NSDictionary *)params
{
    [self _post:urlstr params:params method:@"POST"];
}

- (void)put:(NSString *)urlstr params:(NSDictionary *)params
{
    [self _post:urlstr params:params method:@"PUT"];
}

- (void)_post:(NSString *)urlstr params:(NSDictionary *)params method:(NSString*)method
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
    
    if (_debug) ZZLOG(@"json to post: %@", json);
    
    NSData* postData = [NSData dataWithBytes:[json UTF8String] length:[json length]];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]] forHTTPHeaderField:@"Content-Length"];
    
    // set persistent headers
    for (NSString* key in [persistentHeaders allKeys]) {
        [request setValue:persistentHeaders[key] forHTTPHeaderField:key];
    }
    
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
	[_data setLength:0];
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    _status = [httpResponse statusCode];
	if (_debug) ZZLOG(@"get response from %@ [%ld]", _urlString, (long)_status);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	if (_debug) ZZLOG(@"got %lu bytes", (unsigned long)[data length]);
	[_data appendData:data];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	if (_debug) ZZLOG(@"finish loading successfuly");
	_loaded = YES;
	_loading = NO;

	// parse data
	self.responseString = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
    
	if (_debug) ZZLOG(@"json: %@", self.responseString);
    
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

+ (NSDictionary*)persistentHeaders:(NSDictionary *)headers
{
    if (headers!=nil) {
        persistentHeaders = headers;
    }
    return persistentHeaders;
}

@end
