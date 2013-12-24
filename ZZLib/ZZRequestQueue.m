/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZRequestQueue.h"
#import "ZZDebug.h"
#import "ZZJSONRequest.h"

@implementation ZZRequestQueue

- (id)initWithDelegate:(id<ZZRequestQueueDelegate>)delegate
{
    self = [super init];
	if (self) {
		self.delegate = delegate;
        self.debug = NO;
        _started = NO;
        _finished = NO;
        self.requests = [[NSMutableArray alloc] init];
	}
	return self;
}

- (ZZJSONRequest*)add:(ZZJSONRequest*)request
{
    NSAssert(request.delegate==self, @"Request delegate is not the queue!");
    
    if ([self.requests containsObject:request]) {
        if (self.debug) {
            ZZLOG(@"request already in queue, will not add it again");
        }
    }
    
    [self.requests addObject:request];
    return request;
}

- (void)restart
{
    _started = YES;
    _finished = NO;
}

- (void)start
{
    [self restart];
    [self check];
}

- (void)check
{
    @synchronized(self) {
        // some requests already finished,
        // but it is not time to report the delegate about it
        if (!self.started) {
            if (_debug) ZZLOG(@"not started yet");
            return;
        }
        
        if (self.finished) {
            if (_debug) ZZLOG(@"already finished");
            return;
        }
        
        for (ZZJSONRequest* request in self.requests) {
            if (!request.loaded) {
                return;
            }
        }
        
        _finished = YES;
        
        // all of them is loaded
        if ([_delegate respondsToSelector:@selector(requestQueueAllRequestsFinished:)]) {
            if (_debug) ZZLOG(@"all requests finished");
            [_delegate requestQueueAllRequestsFinished:self];
        } else if (_debug) ZZLOG(@"the delegate is not set?");
    }
}

#pragma mark - ZZJSONRequestDelegate
- (void)requestDidFinishLoading:(ZZJSONRequest *)request
{
    if ([_delegate respondsToSelector:@selector(requestQueue:requestFinished:)]) {
        [_delegate requestQueue:self requestFinished:request];
    }
    [self check];
}

- (void)request:(ZZJSONRequest *)request failedWithError:(NSError *)error
{
    if (self.debug) {
        ZZLOG(@"failed to load the request %@: %@", request.urlString, [error localizedDescription]);
    }
    
    if ([_delegate respondsToSelector:@selector(requestQueue:request:failedWithError:)]) {
        [_delegate requestQueue:self request:request failedWithError:error];
    }
    
    [self check];
}

@end
