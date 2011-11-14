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
    NSString* urlString = [NSString stringWithFormat:
                           @"http://api.flickr.com/services/rest/?method=%@&api_key=%@&text=flower&format=json&nojsoncallback=1",
                           @"flickr.photos.search",
                           @"4a6b9d8c09da17219420854c90c0776a"];
    
    [super createRequest];
	_request = [[ZZJSONRequest alloc] initWithURLString:urlString delegate:self];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoading:(ZZJSONRequest*)request {
	// put necessary part of response in instance variable
	NSDictionary* tmp = (NSDictionary*)_request.response;
    tmp = [tmp objectForKey:@"photos"];
	[_searchResults release];
	_searchResults = [[NSArray alloc] initWithArray:[tmp objectForKey:@"photo"]];
	
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
	
	cell.textLabel.text = [item objectForKey:@"title"];
    NSString* imageUrl = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg",
                          [item objectForKey:@"farm"], [item objectForKey:@"server"], [item objectForKey:@"id"],
                          [item objectForKey:@"secret"]];
    [cell loadImageFromURLStr:imageUrl];
	
    return cell;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* item = [_searchResults objectAtIndex:indexPath.row];
    NSString* imageUrl = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_z.jpg",
                          [item objectForKey:@"farm"], [item objectForKey:@"server"], [item objectForKey:@"id"],
                          [item objectForKey:@"secret"]];

    ZZDemoViewController* viewController = [[ZZDemoViewController alloc] initWithImageURLStr:imageUrl];
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

@end
