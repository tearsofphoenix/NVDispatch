//
//  NVSemaphore.m
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVSemaphore.h"

@implementation NVSemaphore

- (id)initWithCount: (NSInteger)count
{
    if ((self = [super init]))
    {
        _obj = dispatch_semaphore_create(count);
    }
    return self;
}

- (NSInteger)waitWithTimeOutInterval: (dispatch_time_t)timeout
{
    return dispatch_semaphore_wait(_obj, timeout);
}

- (NSInteger)signal
{
    return dispatch_semaphore_signal(_obj);
}

@end
