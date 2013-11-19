/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZDebug.h"
#import "ZZGalleryController.h"
#import "ZZGalleryItem.h"

@implementation ZZGalleryController

@synthesize currentPage = _currentPage;
@synthesize startPage = _startPage;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithInfo:(NSArray*)info {
    self = [super init];
    if (self) {
        _info = info;
        _currentPage = 0;
        _startPage = 0;
        //self.wantsFullScreenLayout = YES;
        self.hidesBottomBarWhenPushed = YES;
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView {
    [super loadView];
    
    _scroll = [[UIScrollView alloc] initWithFrame:self.view.frame];
    _scroll.backgroundColor = [UIColor blackColor];
    _scroll.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    _scroll.showsVerticalScrollIndicator = 
    _scroll.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_scroll];
    
    UITapGestureRecognizer* doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionDoubleTap)];
    doubleTapGesture.numberOfTapsRequired = 2;

    UITapGestureRecognizer* singleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionSingleTap)];
    singleTapGesture.numberOfTapsRequired = 1;
    [singleTapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    [_scroll addGestureRecognizer:singleTapGesture];
    [_scroll addGestureRecognizer:doubleTapGesture];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self layoutScroll:YES];
    [self loadImages];
    [self updateTitle];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutScroll:(BOOL)initial {
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    _scroll.contentSize = CGSizeMake(width*[_info count], height);
    //ZZLOG(@"scroll content %@", NSStringFromCGSize(_scroll.contentSize));
    
    if (initial) {
        // respect startPage
        _scroll.contentOffset = CGPointMake(_startPage*width, 0);
    } else {
        _scroll.contentOffset = CGPointMake(_currentPage*width, 0);
        for (ZZGalleryItem* i in [_scroll subviews]) {
            if (![i isKindOfClass:[ZZGalleryItem class]]) {
                ZZLOG(@"catch scroller, skip it");
                continue;
            }
            i.frame = CGRectMake((i.tag-100)*width, 0, width, height);
            [i fitScaleForFrame:YES];
        }
    }    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _previousStatusBarStyle = [[UIApplication sharedApplication] statusBarStyle];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent];
    self.navigationController.navigationBar.translucent = YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[UIApplication sharedApplication] setStatusBarStyle:_previousStatusBarStyle];
    self.navigationController.navigationBar.translucent = NO;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    // stop loading of images
    for (ZZGalleryItem* i in [_scroll subviews]) {
        if (![i isKindOfClass:[ZZGalleryItem class]]) {
            continue;
        }
        [i cancel];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    for (ZZGalleryItem* i in [_scroll subviews]) {
        if (i.tag!=_currentPage+100 && [i isKindOfClass:[ZZGalleryItem class]]) {
            ZZLOG(@"remove %d before rotation", i.tag-100);
            [i cancel]; // cancel image loading
            [i removeFromSuperview];
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [self layoutScroll:NO];
    [self loadImages];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Scroll View Delegate
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self loadImages];
    [self updateTitle];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Core Methods
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadImages {
    // calculate current page
    _currentPage = floor((_scroll.contentOffset.x - _scroll.frame.size.width / 2) / _scroll.frame.size.width) + 1;
    ZZLOG(@"current page %d", _currentPage);
    
    NSInteger leftPage = _currentPage - 1;
    NSInteger rightPage = _currentPage + 1;
    
    [self loadImage:_currentPage];
    [self loadImage:leftPage];
    [self loadImage:rightPage];
    
    // remove extra pages (save memory)
    NSInteger tag;
    
    for (ZZGalleryItem* v in [_scroll subviews]) {
        if (![v isKindOfClass:[ZZGalleryItem class]]) {
            // must not remove scrollers :)
            continue;
        }
        tag = v.tag - 100;
        if (tag<leftPage || tag>rightPage) {
            ZZLOG(@"remove page %d", tag);
            [v cancel]; // stop loading image
            [v removeFromSuperview];
        }
    }    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadImage:(NSInteger)page {
    if (page<0 || page>[_info count] - 1) {
        ZZLOG(@"out of pages range");
        return;
    }
    
    ZZGalleryItem* item = (ZZGalleryItem*)[_scroll viewWithTag:page + 100];
    
    if (item==nil) {
        ZZLOG(@"create image for page %d", page);
        item = [[ZZGalleryItem alloc] initWithFrame:CGRectMake(_scroll.frame.size.width * page, 0, 
                                                               _scroll.frame.size.width, _scroll.frame.size.height)];
        item.tag = page + 100;
        
        NSDictionary* dict = [_info objectAtIndex:page];
        NSURL* url = [dict objectForKey:@"url"];
        [item loadImageFromURL:url];
        [_scroll addSubview:item];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)actionDone {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)actionSingleTap {
    [self showTop];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)actionDoubleTap {
    ZZGalleryItem* i = (ZZGalleryItem*)[_scroll viewWithTag:_currentPage + 100];
    
    if (i.zoomScale > i.minimumZoomScale) {
        [i setZoomScale:i.minimumZoomScale animated:YES];
    } else {
        [i setZoomScale:i.maximumZoomScale animated:YES];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showTop {
    if (self.navigationController.isNavigationBarHidden) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    } else {
        [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateTitle {
    NSDictionary* d = [_info objectAtIndex:_currentPage];
    self.title = [d objectForKey:@"title"];
}

@end
