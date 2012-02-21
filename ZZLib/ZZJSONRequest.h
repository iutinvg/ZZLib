/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

/**
 Wrapper for NSURLConnection for handful async getting of JSON data.
 
 Usually it is used in pair with ZZTableController or ZZViewController.
 */

#import <Foundation/Foundation.h>
#import "ZZJSONRequestDelegate.h"

/**
 Defines global behaviour for caching.
 You can set this variable to NSURLRequestReturnCacheDataDontLoad if you
 detect that network is unavailable. So you application will able to
 show at least old data.
 Please use SDURLCache library by Grzegorz Adam Hankiewicz, https://github.com/gradha/SDURLCache
 */
extern NSURLRequestCachePolicy ZZURLRequestCachePolicy;
//extern NSURLCacheStoragePolicy ZZURLCacheStoragePolicy;

@interface ZZJSONRequest : NSObject {
	NSString* _urlString;
	NSMutableData* _data;
	id _response;
	NSURLConnection* _connection;
	BOOL _loaded;
	BOOL _loading;
    NSInteger _tag;
	id<ZZJSONRequestDelegate> _delegate;
}

/**
 Request tag.
 
 It can be used to distinguish requests created for the same delegate instance.

    - (void)start2Requests {
        ZZJSONRequest* r = [[ZZJSONRequest alloc] initWithURLString:@"http://url-to-api-1" delegate:self];
        r.tag = 100;
        r = [[ZZJSONRequest alloc] initWithURLString:@"http://url-to-api-2" delegate:self];
        r.tag = 200;
    }
 
    - (void)requestDidFinishLoading:(ZZJSONRequest*)request {
        ...
        if (request.tag==100) {
            ZZLOG(@"this is request from API 1");
        } else if (request.tag==200) {
            ZZLOG(@"this is request from API 2");
        }
        [request release];
        ...
    }
*/
@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, copy) NSString* urlString;

/** 
 Response data.
 
 You can use it when loading is finished.
 Depending on the JSON you get it can be NSArray or NSDictionary.
 Just use casting to access it:
 
	- (void)requestDidFinishLoading:(ZZJSONRequest*)request {
		...
		NSArray* items = (NSArray*)_request.response;
		NSArray* a = a;
		...
	}
 
 @warning You must retain it for futher usage in your methods.
 @see ZZTableController requestDidFinishLoading:]
 @see ZZTableController
 @see ZZJSONRequestDelegate
 */
@property (nonatomic, retain) id response;

/** Current connection used for loading. */
@property (nonatomic, retain) NSURLConnection* connection;

/** Indicates the loading is finished. */
@property (nonatomic, assign) BOOL loaded;

/** Indicates the loading in process. */
@property (nonatomic, assign) BOOL loading;

/**
 Creates request with given URL and delegate.
 
 The request starts loading immediatelly.
 @param urlstr URL string to load data from
 @param delegate NSURLConnection delegate
*/
- (id)initWithURLString:(NSString*)urlstr delegate:(id<ZZJSONRequestDelegate>)delegate;

/**
 Cancels loading of request.
 
 You have to call it when close the screen before data is loaded.
 However, ZZTableController calls it properly at such cases.
 */
- (void)cancel;

@end
