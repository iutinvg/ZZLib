/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZGalleryItem.h"
#import "ZZDebug.h"


@implementation ZZGalleryItem

@synthesize fillOnFit = _fillOnFit;
@synthesize fillingScale = _fillingScale;

////////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.maximumZoomScale = 1.3;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.contentSize = CGSizeMake(frame.size.width, frame.size.height);
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _fillOnFit = NO;
    }
    
    return self;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    [_imageView release];
    [super dealloc];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews  {
    [super layoutSubviews];
    
    ZZLOG(@"layout page %d", self.tag - 100);
    
    // center the image as it becomes smaller than the size of the screen    
    CGSize boundsSize = self.bounds.size;
    
    CGRect frameToCenter = _imageView.frame;
    
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width)
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    else
        frameToCenter.origin.x = 0;
    
    // center vertically
    if (frameToCenter.size.height < boundsSize.height)
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    else
        frameToCenter.origin.y = 0;
    
    _imageView.frame = frameToCenter;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadImageFromURL:(NSURL*)url {
    _imageView = [[ZZImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _imageView.imageDelegate = self;
    [_imageView loadImageFromURL:url];
    [self addSubview:_imageView];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - ZZImageDelegate
////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)imageDidLoad:(ZZImageView*)imageView {
    [_imageView sizeToFit];
    [self fitScaleForFrame:NO];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)fitScaleForFrame:(BOOL)animated {
    CGSize s = _imageView.image.size;
    self.contentSize = s;
    self.minimumZoomScale = MIN(self.frame.size.width / s.width, self.frame.size.height / s.height);
    
    if (self.minimumZoomScale>1) {
        self.maximumZoomScale = self.minimumZoomScale * 1.3;
    }
    
    CGFloat scale;
    if (_fillOnFit) {
        scale = MAX(self.frame.size.width / s.width, self.frame.size.height / s.height);
        _fillingScale = scale;
        ZZLOG(@"fill on fit: %f", scale);
    } else {
        scale = self.minimumZoomScale;
        ZZLOG(@"not fill on fit: %f", scale);
    }
    
    [self setZoomScale:scale animated:animated];
    if (_fillOnFit) {
        [self centerOffset];
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////
- (void)centerOffset {
    ZZLOG(@"frame %@; s frame %@", NSStringFromCGRect(_imageView.frame), NSStringFromCGRect(self.frame));
    CGRect ir = _imageView.frame;
    CGRect sr = self.frame;
    
    CGFloat x = (ir.size.width - sr.size.width) / 2;
    CGFloat y = (ir.size.height - sr.size.height) / 2;
    [self setContentOffset:CGPointMake(x, y)];
}

@end
