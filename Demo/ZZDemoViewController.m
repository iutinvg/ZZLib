/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZDemoViewController.h"

@implementation ZZDemoViewController

- (id)initWithImageURLStr:(NSString*)urlStr
{
    self = [super init];
	if (self) {
		self.title = @"ZZViewController";
        _urlStr = [urlStr copy];
	}
	return self;
}

- (void)loadView
{
	[super loadView];
    
    _image = [[ZZImageView alloc] initWithFrame:CGRectMake(10, 74, 300, 225)];
    _image.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    [_image loadImageFromURLStr:_urlStr];
	
	[self.view addSubview:_image];
}

@end
