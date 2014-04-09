/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <Foundation/Foundation.h>

@class ZZImageView;

@protocol ZZImageDelegate <NSObject>

@optional
- (void)imageDidLoad:(ZZImageView *)imageView;
- (void)imageDidFailed:(NSError *)error;
- (void)imageWrongData:(NSData *)data;
@end
