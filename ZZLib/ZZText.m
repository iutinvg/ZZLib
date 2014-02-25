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
    if ([ZZText isEmpty:string]) {
        return nil;
    }
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    //[formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'+0000'"];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
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

+ (NSAttributedString*)text:(NSString*)text withColor:(UIColor*)color font:(UIFont *)font
{
    NSDictionary* colorDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                               color, NSForegroundColorAttributeName,
                               font, NSFontAttributeName,
                               nil];
    return [[NSAttributedString alloc] initWithString:text attributes:colorDict];
}

+ (NSAttributedString*)t:(NSString*)text c:(UIColor*)color f:(UIFont *)font
{
    return [ZZText text:text withColor:color font:font];
}

+ (NSString*)prettyName:(NSString*)name
{
    name = [[ZZText norm:name] stringByReplacingOccurrencesOfString:@"_" withString:@" "];
    return [name capitalizedString];
}

+ (NSString*)trim:(NSString *)string
{
    return [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
