/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZDemoCatalog.h"
#import "ZZDemoViewController.h"
#import "ZZDemoTableController.h"

@implementation ZZDemoCatalog

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)init {
    self = [super init];
	if (self) {
		self.title = @"ZZCatalog";
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return YES;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Table view data source
///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	
	if (indexPath.row==0) {
		cell.textLabel.text = @"ZZViewVontroller";
	} else if (indexPath.row==1) {
		cell.textLabel.text = @"ZZTableController";
        cell.detailTextLabel.text = @"+ ZZTableViewCell + ZZImageView";
	}

    return cell;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Table view delegate
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row==0) {
		ZZDemoViewController* demoView = [[ZZDemoViewController alloc] init];
		[self.navigationController pushViewController:demoView animated:YES];
		[demoView release];
	} else if (indexPath.row==1) {
		ZZDemoTableController* demoTable = [[ZZDemoTableController alloc] init];
		[self.navigationController pushViewController:demoTable animated:YES];
		[demoTable release];
	}
}

@end
