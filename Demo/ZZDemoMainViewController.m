//
//  ZZDemoMainViewController.m
//  ZZ
//
//  Created by Слава Иутин on 1/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ZZDemoMainViewController.h"


@implementation ZZDemoMainViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.title = NSLocalizedString(@"ZZ Lib Demo", @"Main");
	
	_labelHello = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
	_labelHello.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	_labelHello.textAlignment = UITextAlignmentCenter;
	_labelHello.text = NSLocalizedString(@"Hello World!!!", @"Main");
	
	[self.view addSubview:_labelHello];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
	ZZ_RELEASE(_labelHello);
}

@end
