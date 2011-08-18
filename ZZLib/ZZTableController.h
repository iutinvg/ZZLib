/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZViewController.h"
#import "ZZJSONRequest.h"

/**
 Table loaded with remote data.
 
 Loading is visualized in this controller.
 */
@interface ZZTableController : ZZViewController <UITableViewDataSource, UITableViewDelegate, ZZJSONRequestDelegate> {
	UITableView* _tableView;
	ZZJSONRequest* _request;
	UITableViewStyle _tableViewStyle;
}

@property (nonatomic, assign) UITableViewStyle tableViewStyle;

@property (nonatomic, retain) ZZJSONRequest* request;
@property (nonatomic, retain) IBOutlet UITableView* tableView;

/**
 Default implementation of [ZZJSONRequestDelegate requestDidFinishLoading:]
 
 Must be overriden in order to get loaded data. The super class method must
 be invoked at the end of overriden method. Example:

    NSDictionary* tmp = (NSDictionary*)_request.response;
    [_searchResults release];
    _searchResults = [[NSArray alloc] initWithArray:[tmp objectForKey:@"results"]];
 
    // reload table
    [self.tableView reloadData];
 
    // in case you use ZZTableViewCell 
    [self loadVisibleImages];
 
    // must be called to release request
    // and hide loading visualizations
    [super requestDidFinishLoading:request];
 
 
 @param request request @see [ZZJSONRequestDelegate requestDidFinishLoading:]
 */
- (void)requestDidFinishLoading:(ZZJSONRequest*)request;

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

- (void)createTable;
- (void)refreshData;

@end
