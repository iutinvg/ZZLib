/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZViewController.h"
#import "ZZActivityIndicator.h"
#import "ZZCommon.h"
#import "ZZDebug.h"

@implementation ZZViewController

- (id)init
{
    self = [self initWithNibName:nil bundle:nil];
    
	if (self) {
	}
	
	return self;
}

- (void)loadView
{
	if (nil != self.nibName) {
		[super loadView];		
	} else {		
		self.view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
		self.view.autoresizesSubviews = YES;
		self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.view.backgroundColor = [UIColor whiteColor];
	}
}

- (void)showLoading:(BOOL)flag
{
    ZZActivityIndicator* ai = [ZZActivityIndicator currentIndicator];
    if (flag) {
        [ai displayActivity:@"Loading"];
    } else {
        [ai hide];
    }
}

#pragma mark - ZZJSONRequestDelegate
- (void)request:(ZZJSONRequest*)request failedWithError:(NSError*)error
{
	[self showLoading:NO];
    [self releaseRequest];
}

- (void)requestDidFinishLoading:(ZZJSONRequest*)request
{
	[self showLoading:NO];
    [self releaseRequest];
}

- (void)createRequest
{
	[self showLoading:YES];
}

- (void)releaseRequest
{
    [_request cancel];
    _request = nil;
}

@end
