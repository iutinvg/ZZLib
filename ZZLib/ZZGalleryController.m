#import "ZZGalleryController.h"
#import "ZZGalleryItem.h"
#import "ZZCommon.h"
#import "ZZDebug.h"

@implementation ZZGalleryController

@synthesize currentPage = _currentPage;

@synthesize delegate = _delegate;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithURLs:(NSArray*)URLs andMeta:(NSArray*)meta {
    self = [super init];
    if (self) {
        _URLs = [URLs retain];
        _meta = [meta retain];
        _currentPage = 0;
        self.wantsFullScreenLayout = YES;
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView {
    [super loadView];
    
    CGRect r = self.view.frame;
    
    CGFloat width = MAX(r.size.width, r.size.height);
    CGFloat height = MIN(r.size.width, r.size.height);

    r = CGRectMake(0, 0, width, height);
    
    ZZLOG(@"%@", NSStringFromCGRect(r));
    
    _scroll = [[UIScrollView alloc] initWithFrame:r];
    _scroll.contentSize = CGSizeMake(_scroll.frame.size.width*[_URLs count], _scroll.frame.size.height);
    _scroll.backgroundColor = [UIColor blackColor];
    _scroll.pagingEnabled = YES;
    _scroll.delegate = self;
    
    [self.view addSubview:_scroll];
    
    [self loadImages];
    
    [self setupBottomPanel];

    [self updateCaption];

    UITapGestureRecognizer* doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionDoubleTap)];
    doubleTapGesture.numberOfTapsRequired = 2;
    [_scroll addGestureRecognizer:doubleTapGesture];
    [doubleTapGesture release];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    [_scroll release];
    [_URLs release];
    [_meta release];
    [_labelCurrentCaption release];
    [_labelCurrentDescription release];
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Scroll View Delegate
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self loadImages];
    [self updateCaption];
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
    
    for (UIView* v in [_scroll subviews]) {
        tag = v.tag - 100;
        if (tag<leftPage || tag>rightPage) {
            ZZLOG(@"remove page %d", tag);
            [v removeFromSuperview];
        }
    }    
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadImage:(NSInteger)page {
    if (page<0 || page>[_URLs count] - 1) {
        ZZLOG(@"out of pages range");
        return;
    }
    
    ZZGalleryItem* item = (ZZGalleryItem*)[_scroll viewWithTag:page + 100];
    
    if (item==nil) {
        ZZLOG(@"create image for page %d", page);
        item = [[ZZGalleryItem alloc] initWithFrame:CGRectMake(_scroll.frame.size.width * page, 0, 
                                                             _scroll.frame.size.width, _scroll.frame.size.height)];
        item.fillOnFit = YES;
        item.tag = page + 100;
        [item loadImageFromURL:[_URLs objectAtIndex:page]];
        [_scroll addSubview:item];
        [item release];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setupBottomPanel {
    CGFloat h = 56;
    UIView* panelView = [[UIView alloc] initWithFrame:CGRectMake(0, _scroll.frame.size.height - h, _scroll.frame.size.width, h)];
    panelView.backgroundColor = ZZRGBA(0, 0, 0, 0.7);

    _labelCurrentCaption = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, panelView.frame.size.width-30, 16)];
    _labelCurrentDescription = [[UILabel alloc] initWithFrame:CGRectMake(10, 21, panelView.frame.size.width-30, 33)];
    _labelCurrentCaption.backgroundColor =
    _labelCurrentDescription.backgroundColor = [UIColor clearColor];
    
    _labelCurrentCaption.textColor = [UIColor redColor];
    _labelCurrentCaption.font = [UIFont fontWithName:@"Georgia" size:16];
    _labelCurrentDescription.textColor = [UIColor whiteColor];
    _labelCurrentDescription.font = [UIFont systemFontOfSize:12];
    _labelCurrentDescription.numberOfLines = 0;
    
    [panelView addSubview:_labelCurrentCaption];
    [panelView addSubview:_labelCurrentDescription];
    
    UIImageView* arrow = [[UIImageView alloc] initWithFrame:CGRectMake(_scroll.frame.size.width - 20, 21, 9, 14)];
    arrow.image = [UIImage imageNamed:@"btn_gallery_details.png"];
    [panelView addSubview:arrow];
    [arrow release];

    UIButton* buttonDetails = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, panelView.frame.size.width, panelView.frame.size.height)];
    [buttonDetails addTarget:self action:@selector(actionDetails) forControlEvents:UIControlEventTouchUpInside];
    [panelView addSubview:buttonDetails];
    [buttonDetails release];
    
    [self.view addSubview:panelView];
    [panelView release];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateCaption {
    NSDictionary* dict = [_meta objectAtIndex:_currentPage];
    
    _labelCurrentCaption.text = [dict objectForKey:@"name"];
    _labelCurrentDescription.text = [dict objectForKey:@"description"];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)actionDetails {
    NSDictionary* dict = [_meta objectAtIndex:_currentPage];
    if ([_delegate respondsToSelector:@selector(gallery:listingSelected:)]) {
        [_delegate gallery:self listingSelected:[dict objectForKey:@"id"]];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)actionDoubleTap {
    ZZGalleryItem* i = (ZZGalleryItem*)[_scroll viewWithTag:_currentPage + 100];
    
    CGFloat minScale;
    
    if (i.fillOnFit) {
        minScale = i.fillingScale;
    } else {
        minScale = i.minimumZoomScale;
    }
    
    if (i.zoomScale > minScale) {
        [i setZoomScale:minScale animated:YES];
    } else {
        [i setZoomScale:i.maximumZoomScale animated:YES];
    }
}

@end
