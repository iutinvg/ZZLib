/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <UIKit/UIKit.h>
#import "ZZImageView.h"

@interface ZZTableViewCell : UITableViewCell {
    ZZImageView* _asyncImage;
    NSString* _urlStr;    
}

@property (nonatomic, retain) IBOutlet ZZImageView* asyncImage;
@property (nonatomic, copy) NSString* urlStr;

//+ (CGFloat)calculateHeight:(UITableView*)tableView text:(NSString*)text;
- (void)loadImage;

@end
