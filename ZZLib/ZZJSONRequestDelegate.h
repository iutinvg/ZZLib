/* 
 * Copyright (c) 2011 Whirix <info@whirix.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <UIKit/UIKit.h>

@class ZZJSONRequest;

/**
 Delegate to handle request async loading.
 
 It must be used for controller which uses ZZJSONRequest.
 @see ZZTableController
 */
@protocol ZZJSONRequestDelegate <NSObject>

/**
 Invocated when loading is failed with error.
 
 This method allows to show error alerts, disable loading visualizing. 
 @warning You must call super class method to release request.
 
 @param request the request used for loading
 @param error the failure reason information
 */
- (void)request:(ZZJSONRequest*)request failedWithError:(NSError*)error;

/**
 Invocated when loading successfuly finished.
 
 This method allows to fetch loaded data.
 @warning You must call super class method to release request.

 @param request the request used for loading
 
 @see ZZJSONRequest.request
 */
- (void)requestDidFinishLoading:(ZZJSONRequest*)request;

@end
