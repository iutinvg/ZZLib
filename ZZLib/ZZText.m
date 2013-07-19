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

+ (NSDate*)string2date:(NSString*)string
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    //[formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'+0000'"];
    return [formatter dateFromString:string];
}

@end
