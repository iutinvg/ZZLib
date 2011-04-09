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
 
 You must override this method in inherited class by two reasons:
 
 1. You must release the request.
 2. It may want to call method of super class to disable loading visualizing.
 
 @param request request @see [ZZJSONRequestDelegate requestDidFinishLoading:]
 */
- (void)requestDidFinishLoading:(ZZJSONRequest*)request;

- (void)showActivity:(BOOL)show;
- (void)createRequest;
- (void)createTable;
- (void)refreshData;

@end
