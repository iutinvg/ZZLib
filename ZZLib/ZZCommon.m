//
//  ZZCommon.m
//  MMK
//
//  Created by Слава Иутин on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ZZCommon.h"

///////////////////////////////////////////////////////////////////////////////////////////////////
BOOL ZZIsPad() {
#if __IPHONE_3_2 && __IPHONE_3_2 <= __IPHONE_OS_VERSION_MAX_ALLOWED
	return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad;
#else
	return NO;
#endif
}
