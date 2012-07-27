//
//  NVProcessSource.m
//  NSDispatch
//
//  Created by tearsofphoenix on 7/27/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVProcessSource.h"
#import "NVInternal.h"

@implementation NVProcessSource

- (id)initWithPid: (pid_t)pid
      observeType: (NVProcessObserveType)type
            queue: (NVQueue *)queue
{
    if ((self = [super init]))
    {
        _obj = dispatch_source_create(DISPATCH_SOURCE_TYPE_PROC, pid, type, _NVQueueGetQueue(queue));
    }
    
    return self;
}

- (pid_t)handle
{
    return dispatch_source_get_handle(_obj);
}

- (dispatch_source_proc_flags_t)mask
{
    return dispatch_source_get_mask(_obj);
}

- (dispatch_source_proc_flags_t)data
{
    return dispatch_source_get_data(_obj);
}

@end
