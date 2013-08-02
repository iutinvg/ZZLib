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
 Check if string is empty or `NULL` or `nil` or any other "unpleasant" thing (e.g. not a `NSString` instance).
 
 @param str object to check for emptiness
 @return `YES` if given object is similar to empty string
 */
+ (BOOL)isEmpty:(NSString*)str;

@end
