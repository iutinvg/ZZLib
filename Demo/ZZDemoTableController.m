/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZDemoTableController.h"
#import "ZZDemoViewController.h"
#import "ZZURLHelper.h"

@implementation ZZDemoTableController

- (id)init
{
    self=[super init];
	if (self) {
		self.title = @"ZZTableController";
		
		// refresh button
		self.navigationItem.rightBarButtonItem = 
		[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
													   target:self
													   action:@selector(refreshData)];		
	}
	return self;
}

#pragma mark - Request Handling
- (void)createRequest
{
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"flickr.photos.search", @"method",
                            @"flower", @"text",
                            nil];
    // don't forget a number of persistent params will also be added
    NSString* urlString = [ZZURLHelper urlForMethod:@"" params:params];
    ZZLOG(@"flick url: %@", urlString);
    
    [super createRequest];
	self.request = [[ZZJSONRequest alloc] initWithDelegate:self];
    [self.request get:urlString];
}

- (void)requestDidFinishLoading:(ZZJSONRequest*)request
{
	// put necessary part of response in instance variable
	NSDictionary* tmp = (NSDictionary*)self.request.response;
    tmp = [tmp objectForKey:@"photos"];
	_searchResults = [[NSArray alloc] initWithArray:[tmp objectForKey:@"photo"]];
	
	ZZLOG(@"results: %lu", (long)[_searchResults count]);
	
	// reload table
	[self.tableView reloadData];
    
	// must be called to release request
    // and hide loading visualizations
	[super requestDidFinishLoading:request];
}

- (void)showLoading:(BOOL)flag
{
	[super showLoading:flag];
	
	// enable/disable refresh button
	self.navigationItem.rightBarButtonItem.enabled = !flag;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (_searchResults==nil) {
		return 0;
	}
    return [_searchResults count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"ZZTableViewCell";
    
    ZZTableViewCell *cell = (ZZTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[ZZTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	NSDictionary* item = [_searchResults objectAtIndex:indexPath.row];
	
	cell.textLabel.text = [item objectForKey:@"title"];
    NSString* imageUrl = [NSString stringWithFormat:@"https://farm%@.static.flickr.com/%@/%@_%@_s.jpg",
                          [item objectForKey:@"farm"], [item objectForKey:@"server"], [item objectForKey:@"id"],
                          [item objectForKey:@"secret"]];
    [cell loadImageFromURLStr:imageUrl];
	
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary* item = [_searchResults objectAtIndex:indexPath.row];

    NSString* imageUrl = [NSString stringWithFormat:@"https://farm%@.static.flickr.com/%@/%@_%@_m.jpg",
                          [item objectForKey:@"farm"], [item objectForKey:@"server"], [item objectForKey:@"id"],
                          [item objectForKey:@"secret"]];

    ZZDemoViewController* demoView =
    [[ZZDemoViewController alloc] initWithImageURLStr:imageUrl];
    [self.navigationController pushViewController:demoView animated:YES];
}

@end
