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
/**
 Default implementation of [ZZJSONRequestDelegate requestDidFinishLoading:]
 
 Must be overriden in order to get loaded data. The super class method must
 be invoked at the end of overriden method. Example:
 
 NSDictionary* tmp = (NSDictionary*)_request.response;
 [_searchResults release];
 _searchResults = [[NSArray alloc] initWithArray:[tmp objectForKey:@"results"]];
 
 // reload table
 [self.tableView reloadData];
 
 // in case you use ZZTableViewCell
 [self loadVisibleImages];
 
 // must be called to release request
 // and hide loading visualizations
 [super requestDidFinishLoading:request];
 
 
 @param request request @see [ZZJSONRequestDelegate requestDidFinishLoading:]
 */
- (void)requestDidFinishLoading:(ZZJSONRequest*)request;

@end
