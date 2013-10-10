/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import <Foundation/Foundation.h>
#import "ZZJSONRequestDelegate.h"

@class ZZJSONRequest;
@class ZZRequestQueue;

/**
 Delegate to catch a message when queue's requests are performed.
 */
@protocol ZZRequestQueueDelegate <NSObject>
- (void)requestQueueAllRequestsFinished:(ZZRequestQueue*)queue;
@end

/**
 The purpose of queue is to inform you when all contained requests are performed.
 */
@interface ZZRequestQueue : NSObject <ZZJSONRequestDelegate>

/**
 List of requests.
 */
@property NSMutableArray* requests;

/**
 Indicate the queue is in state if request checking.
 */
@property (readonly) BOOL started;

/**
 Indicates the queue is finished.
 */
@property (readonly) BOOL finished;

/**
 To shows some debug messages.
 */
@property BOOL debug;

@property id<ZZRequestQueueDelegate> delegate;

/**
 C-r.
 */
- (id)initWithDelegate:(id<ZZRequestQueueDelegate>)delegate;

/**
 Allows to start request checking.
 
 The delegate method will be called not earlier than the queue is started.
 It is done to prevent sitiation when queue report about all requests finishing before you add the last request to it.

 The queue object does not start requests. They have to be started by you.
 The only things it does is just checking if all them are finished. Thus the typical
 usage pattern is the following:
 
    - (void)viewDidLoad
    {
        [super viewDidLoad];
 
        queue = [[ZZRequestQueue alloc] initWithDelegate:self];
 
        request1 = [[ZZJSONRequest alloc] initWithDelegate:queue];
        request2 = [[ZZJSONRequest alloc] initWithDelegate:queue];
        request3 = [[ZZJSONRequest alloc] initWithDelegate:queue];
 
        [request1 get:@"some-url1"];
        [request2 get:@"some-url2"];
        [request3 post:@"some-url3" params:nil];
 
        [queue start];
    }
 
    - (void)requestQueueAllRequestsFinished:(ZZRequestQueue *)queue
    {
        // here we know all requests are done
        id data = request1.response;
        
        // hide loading indication, etc
        [self showLoading:NO];
    }
 
 */
- (void)start;

/**
 Add request to the queue.
 
 Please get noted. The requests delegate must be this queue object. Please care about it when creating it.
 Also it does not start the request. You should care about it.
 
 @param request the request to add to queue
 */
- (void)add:(ZZJSONRequest*)request;

/**
 Checks if requests are finished. Calls delegate method if they are.
 */
- (void)check;

@end
