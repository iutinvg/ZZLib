/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZJSONRequest.h"
#import "ZZImageView.h"
#import "ZZDebug.h"

@implementation ZZImageView

@synthesize loaded = _loaded;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self clear];
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	[_connection cancel]; //in case the URL is still downloading
	[_connection release];
	[_data release]; 
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadImageFromURL:(NSURL*)url {
    //in case we are downloading a 2nd image
    [self clear];
    
    // check the cache
    NSURLCache* cache = [NSURLCache sharedURLCache];
    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:ZZURLRequestCachePolicy timeoutInterval:20.0];
    NSCachedURLResponse* response = [cache cachedResponseForRequest:request];
    if (response!=nil) {
        //ZZLOG(@"it is found in cache");
        UIImage* image = [UIImage imageWithData:response.data];
        self.image = image;
        _loaded = YES;
        return;
    }
	
	_connection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; 
    //notice how delegate set to self object
	//TODO error handling, what if connection is nil?
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadImageFromURLStr:(NSString*)urlStr {
    if (urlStr==nil) {
        ZZLOG(@"image url is nil");
        return;
    }
    
    NSURL* url = [NSURL URLWithString:urlStr];
    [self loadImageFromURL:url];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
	if (_data==nil) { 
        _data = [[NSMutableData alloc] initWithCapacity:2048]; 
    } 
	[_data appendData:incrementalData];
    //ZZLOG(@".");
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	[_connection release];
	_connection = nil;
	
    UIImage* image = [UIImage imageWithData:_data];
    self.image = image;
    
	[_data release];
	_data = nil;
    
    _loaded = YES;
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

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)clear {
    [_connection cancel];
    [_connection release];
    _connection = nil;
    [_data release]; 
    _data = nil;
    
    self.image = [UIImage imageNamed:@"loading.png"];
    _loaded = NO;
    // other option to visualize not loaded image
    //self.backgroundColor = [UIColor grayColor];
}

@end
