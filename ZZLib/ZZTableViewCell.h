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

//+ (CGFloat)calculateHeight:(UITableView*)tableView text:(NSString*)text;

/**
 Start loading of remote image.

 Loading starts immediately after calling this message.
 
 @param urlStr string representation of image URL
 */
- (void)loadImageFromURLStr:(NSString*)urlStr;

@end
