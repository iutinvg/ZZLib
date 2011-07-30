/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZDemoViewController.h"


@implementation ZZDemoViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    self=[super init];
	if (self) {
		self.title = @"ZZViewController";		
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    [_image release];
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView {
	[super loadView];
    
    _image = [[ZZImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 225)];
    _image.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                                UIViewAutoresizingFlexibleBottomMargin;
    [_image loadImageFromURLStr:@"https://github.com/iutinvg/ZZLib/raw/master/Demo/monkey.jpg"];
	
	[self.view addSubview:_image];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
	[_image release];
    _image = nil;
}

@end
