#import <UIKit/UIKit.h>
#import "ZZViewController.h"

/**
 Image gallery.
 
 Allows to show remote images in swipe stile with possibility to zoom, rotatation.
 Also it support selection of an image. The best way to change behaviour of the gallery is
 to inherite it.
 
 Usage example:
    NSMutableArray* info = [NSMutableArray array];
 
    NSString* imageUrl = @"http://domain.com/image1.jpg";
    NSString* title = @"image 1";
    NSURL* url = [NSURL URLWithString:imageUrl]; 
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:url, @"url", title, @"title", nil];
    [info addObject:dict];
 
    imageUrl = @"http://domain.com/image2.jpg";
    title = @"image 2";
    url = [NSURL URLWithString:imageUrl]; 
    dict = [NSDictionary dictionaryWithObjectsAndKeys:url, @"url", title, @"title", nil];
    [info addObject:dict];
     
    imageUrl = @"file://path/image3.jpg";
    title = @"image 3";
    url = [NSURL URLWithString:imageUrl]; 
    dict = [NSDictionary dictionaryWithObjectsAndKeys:url, @"url", title, @"title", nil];
    [info addObject:dict];
     
    ZZGalleryController* galleryController = [[ZZGalleryController alloc] initWithInfo:info];
    // start from the 2nd image
    galleryController.startPage = 2;
    [self.navigationController pushViewController:galleryController animated:YES];
    [galleryController release];
 */
@interface ZZGalleryController : ZZViewController <UIScrollViewDelegate> {
    UIScrollView* _scroll;
    NSArray* _info;
    NSInteger _currentPage;
    NSInteger _startPage;
    UIStatusBarStyle _previousStatusBarStyle;
}

/**
 Contains current page number.
 */
@property (nonatomic, assign) NSInteger currentPage;

/**
 Define page to start with. Used after initialization.
 */
@property (nonatomic, assign) NSInteger startPage;

/**
 Initial gallery with information about photos to show.
 
 @param info is array of dictionaries. The dictionary can contain the following keys:
    ´@"url"´ (mandatory) NSURL instance presenting URL for image
    ´@"title"´ (optional) string with image name
 */
- (id)initWithInfo:(NSArray*)info;

/**
 Loads / preloads all necessary pages.
 Removes extra pages. You should not call this directly (unless gallery class inheritage)
 */
- (void)loadImages;

/**
 Loads given page, called from [ZZGalleryController::loadImages]
 */
- (void)loadImage:(NSInteger)page;
- (void)layoutScroll:(BOOL)initial;
/**
 Toggle top bar (status and navigation)
 */
- (void)showTop;

/**
 Update title for shown image. The method must be rewritten to support
 other style of title showing. It is called everytime the image is changed.
 */
- (void)updateTitle;

/**
 Handling close gallery event (done button)
 */
- (void)actionDone;

/**
 Handling single tap. Toggle top bars. 
 @see [ZZGalleryController::showTop]
 */
- (void)actionSingleTap;

/**
 Handling double tap: dounle zoon in / out. 
 */
- (void)actionDoubleTap;


@end
