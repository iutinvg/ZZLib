/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZJSONRequest.h"
#import "ZZImageView.h"
#import "ZZDebug.h"

@implementation ZZImageView

@synthesize loaded = _loaded;
@synthesize imageDelegate = _imageDelegate;

- (id)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self clear];
    }
    return self;
}

- (void)dealloc {
	[_connection cancel]; //in case the URL is still downloading
}

- (void)loadImageFromURL:(NSURL*)url {
    //in case we are downloading a 2nd image
    [self clear];

    // Actually nil URL is OK, but checking it in cache can cause crash
    if (url==nil) {
        //ZZLOG(@"image URL is nil");
        return;
    }
    
    // check the cache
    NSURLCache* cache = [NSURLCache sharedURLCache];
    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:[self cachePolicy]
                                         timeoutInterval:20.0];
    NSCachedURLResponse* response = [cache cachedResponseForRequest:request];
    if (response!=nil) {
        //ZZLOG(@"it is found in cache");
        UIImage* image = [UIImage imageWithData:response.data];
        
        self.image = image;
        _loaded = YES;
        if ([_imageDelegate respondsToSelector:@selector(imageDidLoad:)]) {
            [_imageDelegate imageDidLoad:self];
        }
        return;
    }
	
	_connection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; 
}

- (void)loadImageFromURLStr:(NSString*)urlStr {
    if (![urlStr isKindOfClass:[NSNull class]] && [urlStr length]) {
        NSURL* url = [NSURL URLWithString:urlStr];
        [self loadImageFromURL:url];
    }
}

- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
	if (_data==nil) { 
        _data = [[NSMutableData alloc] initWithCapacity:2048]; 
    } 
	[_data appendData:incrementalData];
    //ZZLOG(@".");
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	_connection = nil;
	
    UIImage* image = [UIImage imageWithData:_data];

    if (image==nil) {
        if ([_imageDelegate respondsToSelector:@selector(imageWrongData:)]) {
            [_imageDelegate imageWrongData:_data];
        }
    } else {
        self.image = image;
    }
    
	_data = nil;
    
    _loaded = YES;
    
    if ([_imageDelegate respondsToSelector:@selector(imageDidLoad:)]) {
        [_imageDelegate imageDidLoad:self];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if ([_imageDelegate respondsToSelector:@selector(imageDidFailed:)]) {
        [_imageDelegate imageDidFailed:error];
    }
    //ZZLOG(@"image loading faied: %@", [error localizedDescription]);
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

- (void)clear {
    [_connection cancel];
    _connection = nil;
    _data = nil;
    
    self.image = [self defaultImage];
    _loaded = NO;
    // other option to visualize not loaded image
    //self.backgroundColor = [UIColor grayColor];
}

- (NSURLRequestCachePolicy)cachePolicy
{
    return ZZURLRequestCachePolicy;
}

- (UIImage *)defaultImage
{
    return [UIImage imageNamed:@"loading.png"];
}

@end
