//
//  ZZRequestDelegate.h
//  ZZ
//
//  Created by Слава Иутин on 3/5/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZZJSONRequest;

@protocol ZZJSONRequestDelegate <NSObject>

- (void)request:(ZZJSONRequest*)request failedWithError:(NSError*)error;
- (void)requestDidFinishLoading:(ZZJSONRequest*)request;

@end
