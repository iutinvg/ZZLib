/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

/**
 Check if current device is iPad.
 @return `YES` if it is iPad, `NO` otherwise.
 */
BOOL ZZIsPad();

/**
 Check if current device is iPhone4 with retina display.
 @return `YES` if it is iPhone4 (with retina), `NO` otherwise.
 */
BOOL ZZIsRetina();

/** 
 iPhone 5 screen height.
 
 Idea is stallen from
 http://stackoverflow.com/questions/12552856/how-to-check-iphone-device-version-in-ios/13068238#13068238
 usage:
 http://stackoverflow.com/questions/12395200/how-to-develop-or-migrate-apps-for-iphone-5-screen-resolution/15631256#15631256
 */
#define HEIGHT_IPHONE_5 568

/**
 Check if current device is iPhone5.
 @return `YES` if it is iPhone5, `NO` otherwise.
 */
BOOL ZZIs5();

/**
 Check if current iOS is 7 or more.

 Short hand for `[[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0`
 
 @return YES is iOS 7 or newer, NO otherwise
 */
BOOL ZZIs7();

/** 
 Short hand for color creation.
 */
#define ZZRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

/** 
 UI Orientation shorthand for `[[UIApplication sharedApplication] statusBarOrientation]`
 
 Best thing to read: http://stackoverflow.com/a/14938444/444966
 */
#define ZZOrientation [[UIApplication sharedApplication] statusBarOrientation]
