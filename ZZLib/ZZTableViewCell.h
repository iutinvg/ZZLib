//
//  ZZTableViewCell.h
//  ZZ
//
//  Created by Слава Иутин on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

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
