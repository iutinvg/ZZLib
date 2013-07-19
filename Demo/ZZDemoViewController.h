/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZ.h"

@interface ZZDemoViewController : ZZViewController {
    ZZImageView* _image;
    NSString* _urlStr;
}

- (id)initWithImageURLStr:(NSString*)urlStr;

@end
