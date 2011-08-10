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
    [_tableView release];
    [super dealloc];
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
	[_tableView release];
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
#pragma mark ZZJSONRequestDelegate
- (void)createRequest {
	[self showLoading:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(ZZJSONRequest*)request failedWithError:(NSError*)error {
	[self showLoading:NO];
    [self releaseRequest];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoading:(ZZJSONRequest*)request {
	[self showLoading:NO];
    [self releaseRequest];
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
    return cell;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIScrollView
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (_request.loading) {
        return;
    }
    [self loadVisibleImages];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate || _request.loading) {
        return;
    }
    [self loadVisibleImages];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Other Methods
///////////////////////////////////////////////////////////////////////////////////////////////////
/*- (void)showActivity:(BOOL)show {
	UIApplication * app = [UIApplication sharedApplication];
	app.networkActivityIndicatorVisible = show;
}*/

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)releaseRequest {
    [_request cancel];    
    [_request release];
    _request = nil;
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

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadVisibleImages {
    NSArray* visibleCells = [_tableView visibleCells];
    for (UITableViewCell* cell in visibleCells) {
        if ([cell isKindOfClass:[ZZTableViewCell class]]) {
            ZZTableViewCell* zzcell = (ZZTableViewCell*)cell;
            [zzcell loadImage];
        }
    }
}

@end
