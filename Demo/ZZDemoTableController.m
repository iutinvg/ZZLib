/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZDemoTableController.h"
#import "ZZDemoViewController.h"
#import "ZZGalleryController.h"
#import "ZZURLHelper.h"

@implementation ZZDemoTableController

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
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

///////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Request Handling
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createRequest {
    [ZZURLHelper startWithBaseURL:@"http://api.flickr.com/services/rest/" persistentParams:nil];
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:
                            @"flickr.photos.search", @"method",
                            @"4a6b9d8c09da17219420854c90c0776a", @"api_key",
                            @"flower", @"text",
                            @"json", @"format",
                            @"1", @"nojsoncallback",
                            nil];
    /*NSString* urlString = [NSString stringWithFormat:
                           @"http://api.flickr.com/services/rest/?method=%@&api_key=%@&text=flower&format=json&nojsoncallback=1",
                           @"flickr.photos.search",
                           @"4a6b9d8c09da17219420854c90c0776a"];*/
    NSString* urlString = [ZZURLHelper urlForMethod:@"" params:params];
    ZZLOG(@"flick url: %@", urlString);
    
    [super createRequest];
	self.request = [[ZZJSONRequest alloc] initWithDelegate:self];
    [self.request getFrom:urlString];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoading:(ZZJSONRequest*)request {
	// put necessary part of response in instance variable
	NSDictionary* tmp = (NSDictionary*)self.request.response;
    tmp = [tmp objectForKey:@"photos"];
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
        cell = [[ZZTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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
    NSMutableArray* info = [NSMutableArray array];
    
    for (NSDictionary* item in _searchResults) {
        NSString* imageUrl = [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_z.jpg",
                              [item objectForKey:@"farm"], [item objectForKey:@"server"], [item objectForKey:@"id"],
                              [item objectForKey:@"secret"]];
        NSURL* url = [NSURL URLWithString:imageUrl];
        NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:url, @"url",
                              [item objectForKey:@"title"], @"title",
                              nil];
        [info addObject:dict];
    }

    ZZGalleryController* galleryController = [[ZZGalleryController alloc] initWithInfo:info];
    // start from the tapped image
    galleryController.startPage = indexPath.row;
    [self.navigationController pushViewController:galleryController animated:YES];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - ZZGalleryProtocol
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)gallery:(ZZGalleryController *)galleryController listingSelected:(NSString *)imageId {
    ZZLOG(@"user would like to see details for %@", imageId);
}

@end
