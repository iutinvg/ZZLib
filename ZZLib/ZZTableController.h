//
//  ZZTableController.h
//

#import "ZZViewController.h"

@interface ZZTableController : ZZViewController <UITableViewDataSource, UITableViewDelegate> {
	UITableView* _tableView;
	NSURLConnection* _conection;
	NSString* _URLString;
	NSMutableData* _data;
	
	BOOL _loaded;
	BOOL _loading;
}

- (void)showActivity:(BOOL)show;

@end
