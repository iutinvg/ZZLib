/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZCommon.h"
#import "ZZDebug.h"
#import "ZZTableController.h"
#import "ZZTableViewCell.h"

/*
 * ZZTableController work flow
 *
 * 1. implement createRequest, it should look like that:
 *		_request = [[ZZJSONRequest alloc] initWithURLString:@"http://some/json" delegate:self];
 *
 *    IMPORTANT: you must release call [_request release] in
 *    requestDidFinishLoading: and request:didFailedWithError: 
 */

@implementation ZZTableController

@synthesize tableViewStyle = _tableViewStyle;
@synthesize request = _request;
@synthesize tableView = _tableView;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    self = [self initWithNibName:nil bundle:nil];
	if (self) {
		_tableViewStyle = UITableViewStylePlain;
	}
	
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    [self releaseRequest];
    [self showLoading:NO];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView {
	// calling of ZZViewController's method
	// it'll do correct creations in case we don't use nib
	[super loadView];
	if (self.nibName==nil) {
		[self createTable];
	}
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidLoad {
	[super viewDidLoad];
	[self refreshData];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
    [self releaseRequest];
	[self showLoading:NO];
    _tableView = nil;
	[super viewDidUnload];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_request!=nil && _request.loading) {
        [self showLoading:NO];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Table view data source
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
	}
	
    return cell;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createTable {
	_tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:_tableViewStyle];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	_tableView.autoresizesSubviews = YES;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;	
	[self.view addSubview:_tableView];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)refreshData {
    // cancel current release 
    [self releaseRequest];
    // create new release
	[self createRequest];
}

@end
