//
//  NSObject.m
//  ZZ
//
//  Created by Slava Iutin on 3/13/13.
//
//

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
