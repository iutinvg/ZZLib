/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

/**
 * Wrapper for NSURLConnection for handful async getting of JSON data.
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
@property (nonatomic, retain) id response;
@property (nonatomic, retain) NSURLConnection* connection;
@property (nonatomic, assign) BOOL loaded;
@property (nonatomic, assign) BOOL loading;

- (id)initWithURLString:(NSString*)urlstr delegate:(id<ZZJSONRequestDelegate>)delegate;
- (void)cancel;

@end
