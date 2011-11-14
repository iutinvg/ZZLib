/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <Foundation/Foundation.h>

@class ZZGalleryController;

@protocol ZZGalleryProtocol <NSObject>

- (void)gallery:(ZZGalleryController*)galleryController listingSelected:(NSString*)listingId;

@end
