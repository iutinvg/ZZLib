//
//  ZZImageDelegate.h
//  HudsonsApp
//
//  Created by Слава Иутин on 10/18/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZZImageView;

@protocol ZZImageDelegate <NSObject>

@optional
- (void)imageDidLoad:(ZZImageView*)imageView;

@end
