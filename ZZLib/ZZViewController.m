//
//  ZZViewController.m
//  MMK
//
//  Created by Слава Иутин on 12/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ZZViewController.h"
#import "ZZDebug.h"

@implementation ZZViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView {
	[super loadView];
	ZZLOG(@"heheh");
	self.view = [[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
	self.view.autoresizesSubviews = YES;
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.view.backgroundColor = [UIColor whiteColor];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
