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

@interface ZZJSONRequest : NSObject {
	NSString* _urlString;
	NSMutableData* _data;
	id _response;
	NSURLConnection* _connection;
	BOOL _loaded;
	BOOL _loading;
	id<ZZJSONRequestDelegate> _delegate;
}


@property (nonatomic, copy) NSString* urlString;

/** 
 Response data.
 
 You can use it when loading is finished.
 Depending on the JSON you get it can be NSArray or NSDictionary.
 Just use casting to access it:
 
 `NSArray* items = (NSArray*)self.request.response;
 NSArray* a = a;`
 
 @warning You must retain it for futher usage in your methods.
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
