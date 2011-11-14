/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZCommon.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL ZZIsPad() {
	return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL ZZIsRetina() {
    return ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2);
}