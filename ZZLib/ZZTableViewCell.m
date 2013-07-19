/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZTableViewCell.h"
#import "ZZImageView.h"
#import "ZZDebug.h"

@implementation ZZTableViewCell

@synthesize asyncImage = _asyncImage;

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

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)prepareForReuse {
    //ZZLOG(@"clear cell image");
    [super prepareForReuse];
    [_asyncImage clear];
    _urlStr = nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadImageFromURLStr:(NSString*)urlStr {
    _urlStr = [urlStr copy];
    
    ZZLOG(@"load image %@", _urlStr);
	
	NSURL* url = [NSURL URLWithString:_urlStr];
	[_asyncImage loadImageFromURL:url];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutSubviews {
	[super layoutSubviews];
    
	CGFloat height = self.contentView.frame.size.height;
	CGFloat margin = self.textLabel.frame.origin.x;
	
	CGRect rect = self.textLabel.frame;
	rect.origin.x = height + margin;
    rect.size.width = self.contentView.frame.size.width - height - margin;
	self.textLabel.frame = rect;
	
	rect = self.detailTextLabel.frame;
	rect.origin.x = height + margin;
    rect.size.width = self.contentView.frame.size.width - height - margin;
	self.detailTextLabel.frame = rect;
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
