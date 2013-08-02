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
    
    @try {
        id obj = str;
        return [obj stringValue];
    }
    @catch (NSException *exception) {
        
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

+ (BOOL)isEmpty:(NSString *)str
{
    str = [ZZText norm:str];
    return ![str length];
}

@end
