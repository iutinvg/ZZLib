/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZCommon.h"
#import "ZZDebug.h"
#import "ZZTableController.h"

/*
 * ZZTableController work flow
 *
 * 1. implement createConection, it should look like that:
 *		_connection = [[NSURLConnection alloc] init....]
 * Please note, you created the connection and you are responsible it,
 * don't forget to release it in connectionDidFinishLoading/conn
 *
 */

@implementation ZZTableController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
	if (self=[super init]) {
		_data = [[NSMutableData alloc] init];
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView {
	[super loadView];
	[self createTable];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
	[_tableView release];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self refreshData];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	[_data release];
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark NSURLConnection delegate
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	NSURL* url = [response URL];
	
	ZZLOG(@"get response from %@", [url absoluteString]);
	[_data setLength:0];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	ZZLOG(@"got %d bytes", [data length]);
	[_data appendData:data];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[self showActivity:NO];
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
#pragma mark Private Methods
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showActivity:(BOOL)show {
	if (!show) {
		self.navigationItem.rightBarButtonItem = 
		[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
													   target:self
													   action:@selector(refreshData)] autorelease];	
		return;
	}
	
	UIActivityIndicatorView* activity = 
	[[UIActivityIndicatorView alloc] 
	 initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	
	self.navigationItem.rightBarButtonItem = 
	[[[UIBarButtonItem alloc] initWithCustomView:activity] autorelease];	
	
	[activity startAnimating];
	[activity release];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createConnection {
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createTable {
	_tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	_tableView.autoresizesSubviews = YES;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;	
	[self.view addSubview:_tableView];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)refreshData {
	[self createConnection];
	[self showActivity:YES];
}

@end
