/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZDemoViewController.h"

@implementation ZZDemoViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithImageURLStr:(NSString*)urlStr {
    self = [super init];
	if (self) {
		self.title = @"ZZViewController";
        _urlStr = [urlStr copy];
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    [_image release];
    [_urlStr release];
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView {
	[super loadView];
    
    _image = [[ZZImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 225)];
    _image.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    [_image loadImageFromURLStr:_urlStr];
	
	[self.view addSubview:_image];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
	[_image release];
    _image = nil;
}

@end
