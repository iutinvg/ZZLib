/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <UIKit/UIKit.h>
#import "ZZImageView.h"

/**
 ZZGalleryController item class representation. In most cases you
 will not use it directly.
 */
@interface ZZGalleryItem : UIScrollView <UIScrollViewDelegate, ZZImageDelegate> {
    ZZImageView* _imageView;
    BOOL _fillOnFit;
    CGFloat _fillingScale;
}

/**
 Flag to set initial scale to the image fill the screen without black gaps around.
 Default value is NO;
 */
@property (nonatomic, assign) BOOL fillOnFit;

/**
 Scale when it fill the screen
 */
@property (nonatomic, assign) CGFloat fillingScale;

- (void)loadImageFromURL:(NSURL*)url;
- (void)fitScaleForFrame:(BOOL)animated;
- (void)centerOffset;

/**
 Stop item loading.
 
 It is necessary in case we remove page before it is loaded.
 */
- (void)cancel;

@end
