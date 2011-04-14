//
//  ZZImageView.h
//  ZZ
//
//  Created by Слава Иутин on 4/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZZImageView : UIImageView {
	//could instead be a subclass of UIImageView instead of UIView, depending on what other features you want to 
	// to build into this class?
    
	NSURLConnection* connection; //keep a reference to the connection so we can cancel download in dealloc
	NSMutableData* data; //keep reference to the data so we can collect it as it downloads
	//but where is the UIImage reference? We keep it in self.subviews - no need to re-code what we have in the parent class
    
    BOOL _loaded;    
}

@property (nonatomic, assign) BOOL loaded;

- (void)loadImageFromURL:(NSURL*)url;
- (void)clear;

@end
