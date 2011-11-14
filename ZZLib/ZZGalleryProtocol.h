#import <Foundation/Foundation.h>

@class ZZGalleryController;

@protocol ZZGalleryProtocol <NSObject>

- (void)gallery:(ZZGalleryController*)galleryController listingSelected:(NSString*)listingId;

@end
