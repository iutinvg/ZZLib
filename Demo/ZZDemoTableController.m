/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZDemoTableController.h"

@implementation ZZDemoTableController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
	if (self=[super init]) {
		self.title = @"ZZTableController";
		
		// refresh button
		self.navigationItem.rightBarButtonItem = 
		[[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
													   target:self
													   action:@selector(refreshData)] autorelease];		
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	[_searchResults release];
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Request Handling
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createRequest {
	_request = [[ZZJSONRequest alloc] 
				initWithURLString:@"http://search.twitter.com/search.json?q=iPhone"
				delegate:self];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoading:(ZZJSONRequest*)request {
	[super requestDidFinishLoading:request];
	
	// put necessary part of response in instance variable
	NSDictionary* tmp = (NSDictionary*)_request.response;
	[_searchResults release];
	_searchResults = [[NSArray alloc] initWithArray:[tmp objectForKey:@"results"]];
	
	// must be done: release request 
	[_request release];
	
	ZZLOG(@"results: %d", [_searchResults count]);
	
	// reload table
	[self.tableView reloadData];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)request:(ZZJSONRequest *)request failedWithError:(NSError *)error {
	[super request:request failedWithError:error];
	// must be done: release request 
	[_request release];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showActivity:(BOOL)show {
	[super showActivity:show];
	
	// enable/disable refresh button
	self.navigationItem.rightBarButtonItem.enabled = !show;
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
	if (_searchResults==nil) {
		return 0;
	}
    return [_searchResults count];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	NSDictionary* item = [_searchResults objectAtIndex:indexPath.row];
	
	cell.textLabel.text = [item objectForKey:@"text"];
	
    return cell;
}

@end
