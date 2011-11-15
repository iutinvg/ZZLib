/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZ.h"
#import "ZZGalleryProtocol.h"

@interface ZZDemoTableController : ZZTableController <ZZGalleryProtocol> {
	NSArray* _searchResults;
}

@end
