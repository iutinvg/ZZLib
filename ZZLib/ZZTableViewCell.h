/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <UIKit/UIKit.h>
#import "ZZImageView.h"

/**
 In fact the cell is oriented to show tweets.
 
 However, it is very handy to display cell with
 remote images in.
 */
@interface ZZTableViewCell : UITableViewCell {
    ZZImageView* _asyncImage;
    NSString* _urlStr;    
}

/**
 Use it to setup the frame of the image.
 */
@property (nonatomic, retain) IBOutlet ZZImageView* asyncImage;

/**
 URL of remote image.
 */
@property (nonatomic, copy) NSString* urlStr;

//+ (CGFloat)calculateHeight:(UITableView*)tableView text:(NSString*)text;

/**
 Start loading of remote image.
 
 The cell instance do not start the loading immediately.
 Just because the cell can be invisible.
 */
- (void)loadImage;

@end
