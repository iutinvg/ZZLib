/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <Foundation/Foundation.h>

/**
 Image-view for remote images. The image loading is async.
 
 Please see Demo part of ZZLib project as a best example of the usage: 
 
 - https://github.com/iutinvg/ZZLib/blob/master/Demo/ZZDemoViewController.h
 - https://github.com/iutinvg/ZZLib/blob/master/Demo/ZZDemoViewController.m
 */
@interface ZZImageView : UIImageView {
	NSURLConnection* _connection;
	NSMutableData* _data;
    
    BOOL _loaded;    
}

/**
 Indicates whether image is loaded or not.
 */
@property (nonatomic, assign) BOOL loaded;

/** 
 Set remote image URL and start loading.
 
 Have to be called in order to start remote image loading.
 
 Usage example:
    - (void)loadView {
        [super loadView];
 
        image = [[ZZImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 225)];
        NSURL* url = [NSURL URLWithString:@"https://github.com/iutinvg/ZZLib/raw/master/Demo/monkey.jpg"];
        [image loadImageFromURL:url];
 
        [self.view addSubview:image];
    }
 
 @param url remote image URL 
 */
- (void)loadImageFromURL:(NSURL*)url;

/**
 Shorthand call for [ZZImageView loadImageFromURL:]
 
 Usage example:
    - (void)loadView {
        [super loadView];
 
        image = [[ZZImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 225)];
        [image loadImageFromURLStr:@"https://github.com/iutinvg/ZZLib/raw/master/Demo/monkey.jpg"];
 
        [self.view addSubview:image];
    }
 
 @param urlStr URL string
 */
- (void)loadImageFromURLStr:(NSString*)urlStr;

/**
 Clear image (show default uploaded state). Cancels current image loading. Set [ZZImageView.loading] property to `NO`. 
 */
- (void)clear;

@end
