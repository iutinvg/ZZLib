/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <UIKit/UIKit.h>

@interface ZZText : NSObject 

/**
 Return capitalized string
 */
+ (NSString*)capitalizeFirst:(NSString*)str;

/**
 Get empty string is nil or NULL, etc
 */
+ (NSString*)norm:(NSString*)str;

@end
