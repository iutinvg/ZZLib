/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZJSONRequest.h"
#import "ZZDebug.h"
#import "JSON.h"

NSURLRequestCachePolicy ZZURLRequestCachePolicy = NSURLRequestUseProtocolCachePolicy;
//NSURLCacheStoragePolicy ZZURLCacheStoragePolicy = NSURLCacheStorageAllowedInMemoryOnly;

@implementation ZZJSONRequest

@synthesize urlString = _urlString;
@synthesize response = _response;
@synthesize connection = _connection;
@synthesize loaded = _loaded;
@synthesize loading = _loading;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithURLString:(NSString*)urlstr delegate:(id<ZZJSONRequestDelegate>)delegate {
    self = [super init];
	if (self) {
		_delegate = delegate;
		self.urlString = urlstr;
		
		NSURL* url = [NSURL URLWithString:_urlString];
		NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:ZZURLRequestCachePolicy timeoutInterval:20];
		_loaded = NO;
		_loading = YES;

		_data = [[NSMutableData alloc] init];		
		_connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];		
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	[self cancel];
	[_connection release];
	[_response release];
	[_data release];
	[super dealloc];
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
	NSString* json = [[[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding] autorelease];
	ZZLOG(@"json: %@", json);
	_response = [[json JSONValue] retain];
	
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

///////////////////////////////////////////////////////////////////////////////////////////////////
/*- (NSCachedURLResponse*)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    NSCachedURLResponse* newResponse =
    [[NSCachedURLResponse alloc] initWithResponse:cachedResponse.response
                                             data:cachedResponse.data
                                         userInfo:cachedResponse.userInfo
                                    storagePolicy:ZZURLCacheStoragePolicy];
    return [newResponse autorelease];
}*/

@end
