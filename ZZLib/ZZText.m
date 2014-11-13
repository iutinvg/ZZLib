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
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    // attempt 1, no fraction part in seconds
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
    // [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'+0000'"];

    NSDate *result = [formatter dateFromString:string];

    // attempt 2, fraction part for seconds
    if (!result) {
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.S'Z'"];
        // [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss.S'+0000'"];
        result = [formatter dateFromString:string];
    }
    return result;
}

+ (NSString*)date2string:(NSDate*)date
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy'-'MM'-'dd'T'HH':'mm':'ss'+0000'"];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
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

+ (BOOL)isValidEmail:(NSString *)value
{
    value = [ZZText norm:value];
    NSString* regexString = @"^[+\\w\\.\\-']+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*(\\.[a-zA-Z]{2,})+$";

    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexString options:NSRegularExpressionCaseInsensitive error:&error];

    if(!error)
    {
        NSUInteger numberOfMatches = [regex numberOfMatchesInString:value options:0 range:NSMakeRange(0, value.length)];
        return numberOfMatches == 1;
    }

    return NO;
}


@end
