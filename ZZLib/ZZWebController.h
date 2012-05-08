/* 
 * Copyright (c) 2012 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZViewController.h"
#import "ZZWebDelegate.h"

/**
 Web controller with toolbar: back, forward and reload.
 Very useful when you need to open a web-page but have to stay in the app.
 */
@interface ZZWebController : ZZViewController <UIWebViewDelegate> {
    UIWebView* _webView;
    UIToolbar* _toolbar;
    NSString* _urlString;
    
    UIBarButtonItem* _buttonBack;
    UIBarButtonItem* _buttonForward;
    UIBarButtonItem* _buttonReload;
    
    id<ZZWebDelegate> _delegate;
}

@property (nonatomic, retain) IBOutlet UIWebView* webView;
@property (nonatomic, retain) IBOutlet UIToolbar* toolbar;
@property (nonatomic, copy) NSString* urlString;

@property (nonatomic, retain) IBOutlet UIBarButtonItem* buttonBack;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* buttonForward;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* buttonReload;

@property (nonatomic, assign) id<ZZWebDelegate> delegate;

/**
 C-r.
 
 @param urlString intial URL to open.
 */
- (id)initWithURLString:(NSString*)urlString;

/**
 Create and setup toolbar. Can be overwritten for customization.
 */
- (void)setupToolbar;
/**
 Enables and disables buttons statuses.
 */
- (void)updateButtonsStatus;

/**
 Back action.
 */
- (IBAction)actionBack:(id)sender;
/**
 Forward action.
 */
- (IBAction)actionForward:(id)sender;
/**
 Reload action.
 */
- (IBAction)actionReload:(id)sender;

- (IBAction)actionDone:(id)sender;

@end
