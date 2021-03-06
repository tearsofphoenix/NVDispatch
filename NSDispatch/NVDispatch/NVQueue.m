//
//  NVQueue.m
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVQueue.h"

@interface NVQueue ()
{
@private
    NSString *_label;
}
@end

static NVQueue * __mainQueue = nil;

@implementation NVQueue

dispatch_queue_t _NVQueueGetQueue(NVQueue * queue)
{
    return queue->_obj;
}

+ (id)globalQueueWithPriority: (NVQueuePriority)priority
{
    NVQueue *queue = [[[self class] alloc] init];
    queue->_obj = dispatch_get_global_queue(priority, 0);
    return [queue autorelease];
}

+ (id)mainQueue
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, (^
                               {
                                   __mainQueue = [[[self class] alloc] init];
                                   __mainQueue->_obj = dispatch_get_main_queue();
                               }));
    return __mainQueue;
}

- (id)initWithLabel: (NSString *)label
          attribute: (NVQueueAttribute)attribute
{
    if ((self = [super init]))
    {
        _label = [label retain];
        
        dispatch_queue_attr_t attr;
        
        if (attribute == NVQueueAttributeSerial)
        {
            attr = DISPATCH_QUEUE_SERIAL;
            
        }else
        {
            attr = DISPATCH_QUEUE_CONCURRENT;
        }
        
        _obj = dispatch_queue_create([_label UTF8String], attr);
    }
    return self;
}

- (NSString *)label
{
    return _label;
}

@end

@implementation NVQueue (Dispatch)

- (void)dispatchBlock: (NVBlock)block
          synchronize: (BOOL)flag
{
    if (flag)
    {
        dispatch_sync(_obj, block);
        
    }else
    {
        dispatch_async(_obj, block);
    }
}

- (void)dispatchFunction: (NVFunction)work
                 context: (void *)context
             synchronize: (BOOL)flag
{
    if (flag)
    {
        dispatch_sync_f(_obj, context, work);
    }else
    {
        dispatch_async_f(_obj, context, work);
    }
}

- (void)applyBlock: (NVIterationBlock)block
          forTimes: (size_t)times
{
    dispatch_apply(times, _obj, block);
}

- (void)applyFunction: (NVIterationFunction)work
              context: (void *)context
             forTimes: (size_t)times
{
    dispatch_apply_f(times, _obj, context, work);
}

- (void)dispatchBlock: (NVBlock)block
            afterTime: (dispatch_time_t)time
{
    dispatch_after(time, _obj, block);
}

- (void)dispatchFunction: (NVFunction)work
                 context: (void *)context
               afterTime: (dispatch_time_t)time
{
    dispatch_after_f(time, _obj, context, work);
}

- (void)dispatchBarrierBlock: (NVBlock)block
                 synchronize: (BOOL)flag
{
    if (flag)
    {
        dispatch_barrier_sync(_obj, block);
        
    }else
    {
        dispatch_barrier_async(_obj, block);
    }
}

- (void)dispatchBarrierFunction: (NVFunction)work
                        context: (void *)context
                    synchronize: (BOOL)flag
{
    if (flag)
    {
        dispatch_barrier_sync_f(_obj, context, work);
        
    }else
    {
        dispatch_barrier_async_f(_obj, context, work);
    }
}

- (void)setContext: (void*)context
            forKey: (const void *)key
        destructor: (NVFunction)destructor
{
    dispatch_queue_set_specific(_obj, key, context, destructor);
}

- (void *)contextForKey: (const void *)key
{
    return dispatch_queue_get_specific(_obj, key);
}

@end

