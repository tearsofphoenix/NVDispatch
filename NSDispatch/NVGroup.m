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

@interface NVGroup ()
{
@private
    dispatch_group_t _group;
}
@end

@implementation NVGroup

- (id)init
{
    if ((self = [super init]))
    {
        _group = dispatch_group_create();
    }
    return self;
}

- (void)addBlock: (NVBlock)block
         toQueue: (NVQueue *)queue
{
    dispatch_group_async(_group, _NVQueueGetQueue(queue), block);
}

- (void)addFunction: (NVFunction)work
            context: (void *)context
            toQueue: (NVQueue *)queue
{
    dispatch_group_async_f(_group, _NVQueueGetQueue(queue), context, work);
}

- (void)waitWithTimeOutInterval: (dispatch_time_t)timeout
{
    dispatch_group_wait(_group, timeout);
}

- (void)setCompletionBlock: (NVBlock)block
                   toQueue: (NVQueue *)queue
{
    dispatch_group_notify(_group, _NVQueueGetQueue(queue), block);
}

- (void)setCompletionFunction: (NVFunction)work
                      context: (void *)context
                      toQueue: (NVQueue *)queue
{
    dispatch_group_notify_f(_group, _NVQueueGetQueue(queue), work, context);
}

- (void)enter
{
    dispatch_group_enter(_group);
}

- (void)leave
{
    dispatch_group_leave(_group);
}


- (id)retain
{
    dispatch_retain(_group);
    return [super retain];
}

- (oneway void)release
{
    dispatch_release(_group);
    [super release];
}

@end
