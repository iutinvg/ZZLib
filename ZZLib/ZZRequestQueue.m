/*
 * Copyright (c) Sevencrayons.com <iutinvg@gmail.com>
 * License: http://www.opensource.org/licenses/mit-license.html
 */

#import "ZZRequestQueue.h"
#import "ZZDebug.h"

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

- (void)add:(ZZJSONRequest*)request
{
    NSAssert(request.delegate==self, @"Request delegate is not the queue!");
    [self.requests addObject:request];
}

- (void)start
{
    _started = YES;
    _finished = NO;
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
    [self check];
}

- (void)request:(ZZJSONRequest *)request failedWithError:(NSError *)error
{
    if (self.debug) {
        ZZLOG(@"failed to load the request %@: %@", request.urlString, [error localizedDescription]);
    }
    [self check];
}

@end
