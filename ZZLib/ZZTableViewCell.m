//
//  ZZTableViewCell.m
//  ZZ
//
//  Created by Слава Иутин on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ZZTableViewCell.h"
#import "ZZImageView.h"
#import "ZZDebug.h"

@implementation ZZTableViewCell

@synthesize asyncImage = _asyncImage;
@synthesize urlStr = _urlStr;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat height = self.contentView.frame.size.height;
        _asyncImage = [[ZZImageView alloc] initWithFrame:CGRectMake(0, 0, height, height)];
        [self.contentView addSubview:_asyncImage];
    }
    return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
    [_asyncImage release];
    [_urlStr release];
    [super dealloc];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)prepareForReuse {
    //ZZLOG(@"clear cell image");
    [super prepareForReuse];
    [_asyncImage clear];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadImage {
	if (_urlStr==nil || _asyncImage.loaded) {
		ZZLOG(@"nothing to load");
		return;
	}
    
    ZZLOG(@"load image %@", _urlStr);
	
	NSURL* url = [NSURL URLWithString:_urlStr];
	[_asyncImage loadImageFromURL:url];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
/*+ (CGFloat)calculateHeight:(UITableView*)tableView text:(NSString*)text {
    //return 165;
    static CGFloat minimalHeight = 50;
    static CGFloat extraWidth = 67;
    static CGFloat top = 30;
    
    CGFloat containerWidth = tableView.frame.size.width;
    
    CGSize s = [text sizeWithFont:[UIFont fontWithName:@"Helvetica" size:14.0] 
                constrainedToSize:CGSizeMake(containerWidth - extraWidth, 2000.0)
                    lineBreakMode:UILineBreakModeWordWrap];
    //ZZLOG(@"%f: %@ (%f)", s.height, text, tableView.frame.size.width);
    return MAX(minimalHeight, s.height+top+7);
}*/

@end
