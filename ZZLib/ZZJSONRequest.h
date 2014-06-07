/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
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
	NSMutableData* _data;
	NSURLConnection* _connection;
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
@property NSInteger tag;

@property (nonatomic, strong) NSString* urlString;

@property (readonly) id<ZZJSONRequestDelegate> delegate;

/**
 Latest response status code.
 */
@property NSInteger status;

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
@property (nonatomic, strong) id response;

@property (nonatomic, strong) NSString* responseString;

/** Current connection used for loading. */
@property (nonatomic, strong) NSURLConnection* connection;

/** Indicates the loading is finished. */
@property BOOL loaded;

/** Indicates the loading in process. */
@property BOOL loading;

@property (nonatomic, strong) NSString* username;
@property (nonatomic, strong) NSString* password;

/**
 Enables more output to debug console. Very useful new API
 investigations.
 */
@property BOOL debug;

/**
 Creates request with given URL and delegate.

 The request starts loading immediatelly.
 @param urlstr URL string to load data from
 @param delegate NSURLConnection delegate
*/
- (id)initWithDelegate:(id<ZZJSONRequestDelegate>)delegate;

/**
 Cancels loading of request.

 You have to call it when close the screen before data is loaded.
 However, ZZTableController calls it properly at such cases.
 */
- (void)cancel;

- (void)authUsername:(NSString*)usernme password:(NSString*)password;

- (void)get:(NSString*)urlstr;
- (void)post:(NSString*)urlstr params:(NSDictionary*)params;
- (void)put:(NSString*)urlstr params:(NSDictionary*)params;

/**
 Performs real post. It is used for POST and PUT.
 
 It is necessary to override and change encoding.
 */
- (void)_post:(NSString *)urlstr params:(NSDictionary *)params method:(NSString*)method;

/**
 Performs DELETE request.
 
 `delete` is a keyword of Objective-C. So we can't use it.
 */
- (void)del:(NSString*)urlstr;

/**
 Sets parameters which will be added to request headers for all requests.

 Usage example:
     - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
         // params to add to every request
         NSDictionary* headers = [NSDictionary dictionaryWithObjectsAndKeys:
                         @"4a6b9d8c09da17219420854c90c0776a", @"x-simpleauth-token",
                         nil];

         [ZZJSONReqeust persistemtHeader:headers]

         [ZZURLHelper startWithBaseURL:@"http://api.flickr.com/services/rest/" persistentParams:nil];

         // ...
     }

 You may also want to use [ZZURLHelper persistentParams:] for similar purposes.

 @param params dictionary to use as key-value pair in headers. Values must be strings.
 */
+ (NSDictionary*)persistentHeaders:(NSDictionary*)headers;

/**
 These delegate methods are defined here to make possible to inherite and override it in child class.
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;

@end
