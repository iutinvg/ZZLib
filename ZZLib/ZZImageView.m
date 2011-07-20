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
	[connection cancel]; //in case the URL is still downloading
	[connection release];
	[data release]; 
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadImageFromURL:(NSURL*)url {
    //in case we are downloading a 2nd image
    [self clear];
	
	NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:ZZURLRequestCachePolicy timeoutInterval:20.0];
	connection = [[NSURLConnection alloc] initWithRequest:request delegate:self]; 
    //notice how delegate set to self object
	//TODO error handling, what if connection is nil?
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadImageFromURLStr:(NSString*)urlStr {
    if (urlStr==nil) {
        NSLog(@"image url is nil");
        return;
    }
    
    NSURL* url = [NSURL URLWithString:urlStr];
    [self loadImageFromURL:url];
}

//the URL connection calls this repeatedly as data arrives
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)theConnection didReceiveData:(NSData *)incrementalData {
	if (data==nil) { 
        data = [[NSMutableData alloc] initWithCapacity:2048]; 
    } 
	[data appendData:incrementalData];
}

//the URL connection calls this once all the data has downloaded
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connectionDidFinishLoading:(NSURLConnection*)theConnection {
	//so self data now has the complete image 
	[connection release];
	connection = nil;
	
	//make an image view for the image
    UIImage* image = [UIImage imageWithData:data];
    self.image = image;
	[self setNeedsLayout];
    
	[data release];
	data = nil;
    
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
    if (connection!=nil) {
        
        [connection cancel];
        [connection release];
        connection = nil;
    } 
	if (data!=nil) { 
        [data release]; 
        data = nil;
    }
    self.image = [UIImage imageNamed:@"loading.png"];
    _loaded = NO;
    // other option to visualize not loaded image
    //self.backgroundColor = [UIColor grayColor];
}

@end
