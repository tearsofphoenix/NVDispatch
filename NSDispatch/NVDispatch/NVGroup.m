//
//  NVGroup.m
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVGroup.h"
#import "NVQueue.h"
#import "NVInternal.h"

@implementation NVGroup

- (id)init
{
    if ((self = [super init]))
    {
        _obj = dispatch_group_create();
    }
    return self;
}

- (void)asynchronizeBlock: (NVBlock)block
                  toQueue: (NVQueue *)queue
{
    dispatch_group_async(_obj, _NVQueueGetQueue(queue), block);
}

- (void)asynchronizeFunction: (NVFunction)work
                     context: (void *)context
                     toQueue: (NVQueue *)queue
{
    dispatch_group_async_f(_obj, _NVQueueGetQueue(queue), context, work);
}

- (void)waitWithTimeOutInterval: (dispatch_time_t)timeout
{
    dispatch_group_wait(_obj, timeout);
}

- (void)setNotifyBlockForCompletion: (NVBlock)block
                            toQueue: (NVQueue *)queue
{
    dispatch_group_notify(_obj, _NVQueueGetQueue(queue), block);
}

- (void)setNotifyFunctionForCompletion: (NVFunction)work
                               context: (void *)context
                               toQueue: (NVQueue *)queue
{
    dispatch_group_notify_f(_obj, _NVQueueGetQueue(queue), work, context);
}

- (void)enter
{
    dispatch_group_enter(_obj);
}

- (void)leave
{
    dispatch_group_leave(_obj);
}

@end
