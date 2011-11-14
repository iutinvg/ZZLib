#import <UIKit/UIKit.h>
#import "ZZViewController.h"
#import "ZZGalleryProtocol.h"

@interface ZZGalleryController : ZZViewController <UIScrollViewDelegate> {
    UIScrollView* _scroll;
    
    NSArray* _URLs;
    NSArray* _meta;
    NSInteger _currentPage;
    
    UILabel* _labelCurrentCaption;
    UILabel* _labelCurrentDescription;
    
    id<ZZGalleryProtocol> _delegate;
}

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) id<ZZGalleryProtocol> delegate;

- (id)initWithURLs:(NSArray*)URLs andMeta:(NSArray*)meta;

/**
 Loads / preloads all necessary pages.
 Removes extra pages.
 */
- (void)loadImages;

/**
 Loads given page, called from [GalleryController::loadImages]
 */
- (void)loadImage:(NSInteger)page;
- (void)setupBottomPanel;
- (void)updateCaption;
- (void)actionDetails;
- (void)actionDoubleTap;

@end
