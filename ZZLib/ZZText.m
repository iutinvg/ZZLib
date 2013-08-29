/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZText.h"

@implementation ZZText

+ (NSString*)norm:(id)obj
{
    if ([obj isKindOfClass:[NSString class]] && [obj length]) {
        return obj;
    }
    
    if ([obj respondsToSelector:@selector(stringValue)]) {
        return [obj stringValue];
    }
    
    return @"";
}

+ (NSDate*)string2date:(NSString*)string
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    //[formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'+0000'"];
    return [formatter dateFromString:string];
}

+ (NSString*)date2string:(NSDate*)date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'+0000'"];
    return [formatter stringFromDate:date];
}

+ (BOOL)isEmpty:(NSString *)str
{
    str = [ZZText norm:str];
    return ![str length];
}

+ (NSAttributedString*)text:(NSString *)text withColor:(UIColor *)color
{
    NSDictionary* colorDict = [[NSDictionary alloc] initWithObjectsAndKeys:color, NSForegroundColorAttributeName, nil];
    return [[NSAttributedString alloc] initWithString:text attributes:colorDict];
}

+ (NSMutableAttributedString*)appendText:(NSString *)text withColor:(UIColor *)color to:(NSMutableAttributedString *)to
{
    if (to==nil) {
        to = [[NSMutableAttributedString alloc] init];
    }
    [to appendAttributedString:[ZZText text:text withColor:color]];
    
    return to;
}

@end
