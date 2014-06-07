/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZJSONRequest.h"
#import "ZZDebug.h"

NSURLRequestCachePolicy ZZURLRequestCachePolicy = NSURLRequestUseProtocolCachePolicy;
//NSURLCacheStoragePolicy ZZURLCacheStoragePolicy = NSURLCacheStorageAllowedInMemoryOnly;

NSInteger ZZTimeoutInterval = 10;

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
                                                       timeoutInterval:ZZTimeoutInterval];
    request.HTTPMethod = method;
    
    // set persistent headers
    for (NSString* key in [persistentHeaders allKeys]) {
        [request setValue:persistentHeaders[key] forHTTPHeaderField:key];
        if (self.debug) {
            ZZLOG(@"set header %@: %@", key, persistentHeaders[key]);
        }
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
                                                       timeoutInterval:ZZTimeoutInterval];
    request.HTTPMethod = method;
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (_debug) ZZLOG(@"json to post: %@", params);

    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];

    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]] forHTTPHeaderField:@"Content-Length"];
    
    // set persistent headers
    for (NSString* key in [persistentHeaders allKeys]) {
        [request setValue:persistentHeaders[key] forHTTPHeaderField:key];
        if (self.debug) {
            ZZLOG(@"set header %@: %@", key, persistentHeaders[key]);
        }
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
    NSError *error = nil;
    _response = [NSJSONSerialization JSONObjectWithData:_data options:kNilOptions error:&error];
    self.responseString = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];

    if (error==nil) {
        if (_debug) {
            ZZLOG(@"JSON: %@", [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:_response options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding]);
        }
    } else {
        ZZLOG(@"JSON parse error: %@", [error localizedDescription]);
        if (_debug) {
            ZZLOG(@"got string: %@", self.responseString);
        }
    }


	if ([_delegate respondsToSelector:@selector(requestDidFinishLoading:)]) {
		[_delegate requestDidFinishLoading:self];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if (_debug) ZZLOG(@"connection failed with error: %@", [error localizedDescription]);
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
    NSString *authValue;

    // http://stackoverflow.com/a/19794564/444966
    if ([authData respondsToSelector:@selector(base64EncodedStringWithOptions:)]) {
        authValue = [authData base64EncodedStringWithOptions:kNilOptions];  // iOS 7+
    }/* else {
        authValue = [authData base64Encoding];                              // pre iOS7
    }*/

    authValue = [NSString stringWithFormat:@"Basic %@", authValue];

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
