//
//  NVSemaphore.m
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVSemaphore.h"

@interface NVSemaphore ()
{
@private
    dispatch_semaphore_t _semaphore;
}
@end

@implementation NVSemaphore

- (id)initWithCount: (NSInteger)count
{
    if ((self = [super init]))
    {
        _semaphore = dispatch_semaphore_create(count);
    }
    return self;
}

- (NSInteger)waitWithTimeOutInterval: (dispatch_time_t)timeout
{
    return dispatch_semaphore_wait(_semaphore, timeout);
}

- (NSInteger)signal
{
    return dispatch_semaphore_signal(_semaphore);
}


- (id)retain
{
    dispatch_retain(_semaphore);
    return [super retain];
}

- (oneway void)release
{
    dispatch_release(_semaphore);
    [super release];
}

@end
