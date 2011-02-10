//
//  ZZTableController.h
//

#import "ZZViewController.h"

@interface ZZTableController : ZZViewController <UITableViewDataSource, UITableViewDelegate> {
	UITableView* _tableView;
	NSURLConnection* _conection;
	NSMutableData* _data;
	
	BOOL _loaded;
}

- (void)showActivity:(BOOL)show;
- (void)createConnection;
- (void)createTable;
- (void)refreshData;

@end
