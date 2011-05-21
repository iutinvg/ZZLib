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
- (void)viewDidLoad {
	[super viewDidLoad];
	
	_labelHello = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
	_labelHello.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	_labelHello.textAlignment = UITextAlignmentCenter;
	_labelHello.text = @"Hello World!!!";
	
	[self.view addSubview:_labelHello];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
	[_labelHello release];
}

@end
