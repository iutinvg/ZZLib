/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZViewController.h"
#import "ZZCommon.h"
#import "ZZDebug.h"

@implementation ZZViewController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    self = [self initWithNibName:nil bundle:nil];
    
	if (self) {
	}
	
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView {
	if (nil != self.nibName) {
		[super loadView];		
	} else {		
		self.view = [[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds] autorelease];
		self.view.autoresizesSubviews = YES;
		self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.view.backgroundColor = [UIColor whiteColor];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showLoading:(BOOL)flag {
	if (!flag) {
		_loadingView.hidden = YES;
		[_loadingView removeFromSuperview];
		[_loadingView release];
		_loadingView = nil;
		return;
	}
    
    if (_loadingView!=nil) {
        return;
    }
	
	_loadingView = [[UIView alloc] initWithFrame:self.view.bounds];
	_loadingView.backgroundColor = ZZRGBA(0, 0, 0, 0.5);
	_loadingView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	UIActivityIndicatorView* activity = 
	[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	
	activity.center = _loadingView.center;
	activity.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
	UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	
	[_loadingView addSubview:activity];
	[activity startAnimating];
	[activity release];
	
	[self.view addSubview:_loadingView];
}

@end
