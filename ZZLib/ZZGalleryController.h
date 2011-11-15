#import <UIKit/UIKit.h>
#import "ZZViewController.h"

@interface ZZGalleryController : ZZViewController <UIScrollViewDelegate> {
    UIScrollView* _scroll;
    NSArray* _info;
    NSInteger _currentPage;
    NSInteger _startPage;
    UIStatusBarStyle _previousStatusBarStyle;
}

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger startPage;

- (id)initWithInfo:(NSArray*)info;

/**
 Loads / preloads all necessary pages.
 Removes extra pages.
 */
- (void)loadImages;

/**
 Loads given page, called from [GalleryController::loadImages]
 */
- (void)loadImage:(NSInteger)page;
- (void)layoutScroll:(BOOL)initial;
- (void)showTop;

- (void)actionDone;
- (void)actionSingleTap;
- (void)actionDoubleTap;


@end
