/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZCommon.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL ZZIsPad() {
#if __IPHONE_3_2 && __IPHONE_3_2 <= __IPHONE_OS_VERSION_MAX_ALLOWED
	return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
#else
	return NO;
#endif
}
