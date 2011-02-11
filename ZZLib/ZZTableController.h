/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZViewController.h"

@interface ZZTableController : ZZViewController <UITableViewDataSource, UITableViewDelegate> {
	UITableView* _tableView;
	NSURLConnection* _conection;
	NSMutableData* _data;
	
	BOOL _loaded;
	
	UITableViewStyle _tableViewStyle;
}

@property (nonatomic, assign) UITableViewStyle tableViewStyle;
@property (nonatomic, assign) BOOL loaded;

- (void)showActivity:(BOOL)show;
- (void)createConnection;
- (void)createTable;
- (void)refreshData;

@end
