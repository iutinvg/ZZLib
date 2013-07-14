/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZText.h"

@implementation ZZText

+ (NSString*)norm:(NSString *)str
{
    if ([str isKindOfClass:[NSString class]] && [str length]) {
        return str;
    }
    return @"";
}

+ (NSString*)capitalizeFirst:(NSString *)str
{
    str = [ZZText norm:str];
    if ([str length]) {
        str = [str stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                           withString:[[str substringToIndex:1] uppercaseString]];
    }
    return str;
}

@end
