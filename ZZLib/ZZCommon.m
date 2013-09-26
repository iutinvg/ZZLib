/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZCommon.h"

BOOL ZZIsPad()
{
	return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

BOOL ZZIsRetina()
{
    return ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2);
}

BOOL ZZIs5()
{
    return ([[UIScreen mainScreen] bounds].size.height == HEIGHT_IPHONE_5);
}

BOOL ZZIs7()
{
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0;
}