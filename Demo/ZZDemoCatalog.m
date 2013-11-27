/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZDemoCatalog.h"
#import "ZZDemoViewController.h"
#import "ZZDemoTableController.h"
#import "ZZWebController.h"
#import "UIView+ZZFontSetter.h"

// fonts
#define FONT_9 [UIFont fontWithName:@"AmericanTypewriter-Light" size:9]
#define FONT_9B [UIFont fontWithName:@"AmericanTypewriter-CondensedBold" size:9]

@implementation ZZDemoCatalog

- (id)init
{
    self = [super init];
	if (self) {
		self.title = @"ZZCatalog";
	}
	return self;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
	
	if (indexPath.row==0) {
		cell.textLabel.text = @"ZZViewVontroller";
        cell.detailTextLabel.text = @"+ ZZImageView";
	} else if (indexPath.row==1) {
		cell.textLabel.text = @"ZZTableController";
        cell.detailTextLabel.text = @"+ ZZTableViewCell + ZZImageView";
	} else if (indexPath.row==2) {
		cell.textLabel.text = @"ZZWebController";
        cell.detailTextLabel.text = @"http://sevencrayons.com";
        [cell setAllFonts:FONT_9 bold:FONT_9B];
    }

    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row==0) {
		ZZDemoViewController* demoView = 
        [[ZZDemoViewController alloc] initWithImageURLStr:@"https://github.com/iutinvg/ZZLib/raw/master/Demo/monkey.jpg"];
		[self.navigationController pushViewController:demoView animated:YES];
	} else if (indexPath.row==1) {
		ZZDemoTableController* demoTable = [[ZZDemoTableController alloc] init];
		[self.navigationController pushViewController:demoTable animated:YES];
	} else if (indexPath.row==2) {
        ZZWebController* webController = [[ZZWebController alloc] initWithURLString:@"http://sevencrayons.com"];
        webController.title = @"sevencrayons.com";
        [self.navigationController pushViewController:webController animated:YES];
    }
}

@end
