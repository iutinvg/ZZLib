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

/**
 Translate ISO 8601 formatted datetime string (e.g. "2013-07-19T15:12:34+0000") into string.
 
 Good link about it: http://stackoverflow.com/questions/4380381/how-to-convert-string-to-date-in-objective-c
 
 @param string ISO 8601 formatted datetime string to convert
 */
+ (NSDate*)string2date:(NSString*)string;

@end
