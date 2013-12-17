/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
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
    _timerLoadingIndication = nil;
    _timerHideIndication = nil;
}

- (void)dealloc
{
    [self invalidateTimers];
}

- (void)showLoading:(BOOL)flag
{
    if (flag) {
        [self scheduleIndicationShowing];
    } else {
        [self invalidateTimers];
        [[ZZActivityIndicator currentIndicator] hide];
        [self scheduleIndicationHiding];
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

#pragma mark - Loadin Indicator
- (void)scheduleIndicationShowing
{
    _timerLoadingIndication = [NSTimer scheduledTimerWithTimeInterval:1
                                                               target:self
                                                             selector:@selector(doShowLoading)
                                                             userInfo:nil repeats:NO];
}

- (void)scheduleIndicationHiding
{
    _timerHideIndication = [NSTimer scheduledTimerWithTimeInterval:1
                                                            target:self
                                                          selector:@selector(doHideLoading)
                                                          userInfo:nil repeats:NO];
}

- (void)doShowLoading
{
    [[ZZActivityIndicator currentIndicator] displayActivity:NSLocalizedString(@"Loading", @"Common")];
}

- (void)doHideLoading
{
    [self invalidateTimers];
    [[ZZActivityIndicator currentIndicator] hide];
}

- (void)invalidateTimers
{
    [_timerLoadingIndication invalidate];
    _timerLoadingIndication = nil;
    
    [_timerHideIndication invalidate];
    _timerHideIndication = nil;
}

@end
