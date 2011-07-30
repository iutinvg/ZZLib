/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <Foundation/Foundation.h>


@interface ZZImageView : UIImageView {
	NSURLConnection* _connection;
	NSMutableData* _data;
    
    BOOL _loaded;    
}

@property (nonatomic, assign) BOOL loaded;

- (void)loadImageFromURL:(NSURL*)url;

/**
 Shorthand call for loadImageFromURL.
 */
- (void)loadImageFromURLStr:(NSString*)urlStr;

- (void)clear;

@end
