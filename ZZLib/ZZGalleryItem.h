#import <UIKit/UIKit.h>
#import "ZZImageView.h"

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

@end
