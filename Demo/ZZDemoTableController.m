/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZDemoTableController.h"
#import "JSON.h"

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
- (void)createConnection {
	NSURL* url = [NSURL URLWithString:@"http://search.twitter.com/search.json?q=iPhone"];
	NSURLRequest* request = [NSURLRequest requestWithURL:url];
	_conection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	[super connectionDidFinishLoading:connection];
	[_conection release];

	// parse data
	NSString* json = [[[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding] autorelease];
	NSDictionary* hash = [json JSONValue];
	_searchResults = [[NSArray alloc] initWithArray:[hash objectForKey:@"results"]];
	
	// reload table
	[_tableView reloadData];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showActivity:(BOOL)show {
	[super showActivity:show];
	
	// enable/disable refresh button
	self.navigationItem.rightBarButtonItem.enabled = !show;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	[_searchResults release];
	[super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Table view data source
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	if (!_loaded) {
		return 1;
	}
	return 1;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if (!_loaded) {
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
