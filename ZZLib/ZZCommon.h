//
//  ZZCommon.h
//  MMK
//
//  Created by Слава Иутин on 10/25/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

BOOL ZZIsPad();

#define ZZRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define ZZ_INVALIDATE_TIMER(t) [t invalidate]; t = nil;
#define ZZ_RELEASE(v) [v release]; v = nil;
