//
//  ZZTableController.m
//

#import "ZZCommon.h"
#import "ZZTableController.h"

@implementation ZZTableController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
	if (self=[super init]) {
		_data = [[NSMutableData alloc] init];
		_loaded = NO;
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView {
	[super loadView];
	
	_tableView = [[UITableView alloc] init];
	_tableView.dataSource = self;
	_tableView.delegate = self;
	_tableView.autoresizesSubviews = YES;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	[self.view addSubview:_tableView];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidUnload {
	ZZ_RELEASE(_tableView);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	[self showActivity:YES];
	_loaded = NO;
	_loading = YES;
	
	// begin request
	NSURL* url = [NSURL URLWithString:_URLString];
	NSURLRequest* request = [NSURLRequest requestWithURL:url];
	_conection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
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
	ZZLOG(@"get response from %@", _URLString);
	[_data setLength:0];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	ZZLOG(@"got %d bytes", [data length]);
	[_data appendData:data];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	ZZ_RELEASE(connection);
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
		self.navigationItem.rightBarButtonItem = nil;
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

@end
