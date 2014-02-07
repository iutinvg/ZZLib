/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZJSONRequest.h"

/** 
 Short hand for creation of view controller with white view stretched to 
 full screen and with support of all interface orientations.
 
 Please see Demo part of ZZLib project as a best example of the usage: 
 
 - https://github.com/iutinvg/ZZLib/blob/master/Demo/ZZDemoViewController.h
 - https://github.com/iutinvg/ZZLib/blob/master/Demo/ZZDemoViewController.m
 */
@interface ZZViewController : UIViewController <ZZJSONRequestDelegate> {
    NSTimer* _timerLoadingIndication;
    NSTimer* _timerHideIndication;
}

@property ZZJSONRequest* request;

/**
 Must be overriden to create relevant request for your application.
 The default method just show activity idicator.
 
 Example:
 - (void)createRequest {
 [super createRequest];
 _request = [[ZZJSONRequest alloc]
 initWithURLString:@"http://search.twitter.com/search.json?q=iPhone"
 delegate:self];
 }
 
 */
- (void)createRequest;

/**
 It cancel and release the current request. It is called by
 [ZZJSONRequestDelegate requestDidFinishLoading:].
 */

- (void)releaseRequest;
/**
 Creates/removes a view for visualizing of loading process.
 
 You will need it in case of usage this class in pair with ZZJSONRequest or similar.
 Default implementation is very simple: white background with activity indicator in the center.
 Please override if necessary. It is not necessary to involve the super class method in your one,
 though you may of course.
 
 Usage example:
    - (void)viewDidLoad {
        [super viewDidLoad];
        // starting loading process here
        [self showLoading:YES];
    }
 
 @param flag `YES` to creates loading view, `NO` to remove
 */
- (void)showLoading:(BOOL)flag;

/**
 Finds first responder in the given view.
 
 You may need it if you want to know the current editable textfield for example.
 
 @param view the view to search first responder in.
 */
- (UIView*)findFirstResponderBeneathView:(UIView*)view;

/**
 Hides keyboard.
 */
- (void)hideKeyboard;

@end
