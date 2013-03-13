//
//  NSObject.h
//  ZZ
//
//  Created by Slava Iutin on 3/13/13.
//
//

#import <UIKit/UIKit.h>

@interface ZZText : NSObject 

+ (NSString*)capitalizeFirst:(NSString*)str;

/**
 Get empty string is nil or NULL, etc
 */
+ (NSString*)norm:(NSString*)str;

@end
