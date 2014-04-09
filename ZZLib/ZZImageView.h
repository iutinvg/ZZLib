/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <Foundation/Foundation.h>
#import "ZZImageDelegate.h"

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
 To handle image did load event.
 */
@property (nonatomic, unsafe_unretained) id<ZZImageDelegate> imageDelegate;

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
 Clear image: cancels current image loading, set loaded property to `NO`, shows default image. 
 */
- (void)clear;

/**
 Possibility to change cache policy for inherited classes.
 
 Default implementation returns `ZZURLRequestCachePolicy`, which is 
 global cache policy setup option.
 */
- (NSURLRequestCachePolicy)cachePolicy;

/**
 Image to use by default.
 
 This image can be displayed while the remote image is loading.
 */
- (UIImage *)defaultImage;

@end
