/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZDemoTableController.h"
#import "ZZDemoViewController.h"

@implementation ZZDemoTableController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    self=[super init];
	if (self) {
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
#pragma mark - Request Handling
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createRequest {
    [super createRequest];
	_request = [[ZZJSONRequest alloc] 
				initWithURLString:@"http://search.twitter.com/search.json?q=iPhone"
				delegate:self];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoading:(ZZJSONRequest*)request {
	// put necessary part of response in instance variable
	NSDictionary* tmp = (NSDictionary*)_request.response;
	[_searchResults release];
	_searchResults = [[NSArray alloc] initWithArray:[tmp objectForKey:@"results"]];
	
	ZZLOG(@"results: %d", [_searchResults count]);
	
	// reload table
	[self.tableView reloadData];
    
	// must be called to release request
    // and hide loading visualizations
	[super requestDidFinishLoading:request];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showLoading:(BOOL)flag {
	[super showLoading:flag];
	
	// enable/disable refresh button
	self.navigationItem.rightBarButtonItem.enabled = !flag;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Table view data source
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
    
    static NSString *CellIdentifier = @"ZZTableViewCell";
    
    ZZTableViewCell *cell = (ZZTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[ZZTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	NSDictionary* item = [_searchResults objectAtIndex:indexPath.row];
	
	cell.textLabel.text = [item objectForKey:@"text"];
    [cell loadImageFromURLStr:[item objectForKey:@"profile_image_url"]];
	
    return cell;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* item = [_searchResults objectAtIndex:indexPath.row];
    ZZDemoViewController* viewController = [[ZZDemoViewController alloc] initWithImageURLStr:[item objectForKey:@"profile_image_url"]];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

@end
