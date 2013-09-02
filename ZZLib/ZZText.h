/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <UIKit/UIKit.h>

/**
 A number of simple and often used text utils.
 */
@interface ZZText : NSObject 

/**
 Return capitalized string.
 Short hand for `[str stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[str substringToIndex:1] uppercaseString]]`.
 
 @param str string to capitalize, can be `nil`, `NULL` or not `NSString` instance.
 @return capitalized string
 */
+ (NSString*)capitalizeFirst:(NSString*)str;

/**
 Get empty string for given `nil`, `NULL`. Tries to call `stringValue` method.
 It's to simplify empty string checking if you want to have an empty string for a corresponding value.
 
 @param str to normalize, if `NULL`, `nil`, `@""` or object which doesn't have `stringValue` method is given `@""` will be returned. Or given string otherwise.
 @return `NSString` instance
 */
+ (NSString*)norm:(NSString*)str;

/**
 Translate ISO 8601 formatted datetime string (e.g. "2013-07-19T15:12:34+0000") into string.
 
 Good link about it: http://stackoverflow.com/questions/4380381/how-to-convert-string-to-date-in-objective-c
 
 @param string ISO 8601 formatted datetime string to convert
 */
+ (NSDate*)string2date:(NSString*)string;

/**
 Converts date to ISO 8601 formatted datetime string (e.g. "2013-08-20T15:12:34+0000").
 
 @param date the date to convert
 @return ISO 8601 formatted datetime string
 */
+ (NSString*)date2string:(NSDate*)date;

/**
 Check if string is empty or `NULL` or `nil` or any other "unpleasant" thing (e.g. not a `NSString` instance).
 
 @param str object to check for emptiness
 @return `YES` if given object is similar to empty string
 */
+ (BOOL)isEmpty:(NSString*)str;

/**
 Shorthand for getting of colored text.

 Usage:
    NSMutableAttributedString* attrStr = [[NSMutableAttributedString alloc] init];
    [attrStr appendAttributedString:[ZZText text:@"Hello " withColor:[UIColor redColor]];
    [attrStr appendAttributedString:[ZZText text:@"world" withColor:[UIColor greenColor]];
    textLabel.attributedText = attrStr;
 
 @param text string to wrap with color
 @param color the color to use for wrapping
 */
+ (NSAttributedString*)text:(NSString*)text withColor:(UIColor*)color;

/**
 Shorthand useful when you need several colors in the same string.
 
 Usage:
    NSMutableAttributedString* attrStr = [ZZText appendText:@"Hello " withColor:[UIColor redColor] to:nil];
    [ZZText appendText:@" world" withColor:[UIColor greenColor] to:attrStr];
    textLabel.attributedText = attrStr;
 
 @param to mutable string will be appended with given text, also this string will be returned, if it is `nil` then
    it'll be created
 */
+ (NSMutableAttributedString*)appendText:(NSString*)text withColor:(UIColor*)color to:(NSMutableAttributedString*)to;

/**
 Translate string like "first_name" to "First Name". Just like
 Django library does for model field names. 
 
 @see ``django.forms.forms``,
 https://github.com/django/django/blob/master/django/forms/forms.py
 
 @param name string to get pretty name
 @return string pretty name
 */
+ (NSString*)prettyName:(NSString*)name;

@end
