//
//  NVTimerSource.m
//  NSDispatch
//
//  Created by tearsofphoenix on 7/27/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVTimerSource.h"
#import "NVInternal.h"
    
@implementation NVTimerSource

- (id)initWithQueue: (NVQueue *)queue
{
    if ((self = [super init]))
    {
        _obj = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _NVQueueGetQueue(queue));
    }
    return self;
}

- (NSUInteger)data
{
    return dispatch_source_get_data(_obj);
}

@end
