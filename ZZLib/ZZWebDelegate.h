/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <Foundation/Foundation.h>

@class ZZWebController;

@protocol ZZWebDelegate <NSObject>

@optional
- (void)webControllerDone:(ZZWebController*)webController;

@end
