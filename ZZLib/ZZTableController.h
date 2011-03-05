/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZViewController.h"
#import "ZZJSONRequest.h"

@interface ZZTableController : ZZViewController <UITableViewDataSource, UITableViewDelegate, ZZJSONRequestDelegate> {
	UITableView* _tableView;
	ZZJSONRequest* _request;
	UITableViewStyle _tableViewStyle;
}

@property (nonatomic, assign) UITableViewStyle tableViewStyle;
@property (nonatomic, retain) ZZJSONRequest* request;
@property (nonatomic, retain) UITableView* tableView;

- (void)showActivity:(BOOL)show;
- (void)createRequest;
- (void)createTable;
- (void)refreshData;

@end
