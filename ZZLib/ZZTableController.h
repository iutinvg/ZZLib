/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZViewController.h"

/**
 Table loaded with remote data.
 
 Loading is visualized in this controller.
 */
@interface ZZTableController : ZZViewController <UITableViewDataSource, UITableViewDelegate> {
	UITableView* _tableView;
	UITableViewStyle _tableViewStyle;
}

@property (nonatomic, assign) UITableViewStyle tableViewStyle;
@property (nonatomic, strong) IBOutlet UITableView* tableView;

- (void)createTable;
- (void)refreshData;

@end
