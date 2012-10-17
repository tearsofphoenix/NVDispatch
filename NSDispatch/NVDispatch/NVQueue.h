//
//  NVQueue.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dispatch/queue.h>

#import "NVObject.h"

enum
{
    NVQueuePriorityDefault = DISPATCH_QUEUE_PRIORITY_DEFAULT,
    NVQueuePriorityHigh = DISPATCH_QUEUE_PRIORITY_HIGH,
    NVQueuePriorityLow = DISPATCH_QUEUE_PRIORITY_LOW,
    NVQueuePriorityBackground = DISPATCH_QUEUE_PRIORITY_BACKGROUND,
};

enum
{
    NVQueueAttributeSerial,
    NVQueueAttributeConcurrent,
    NVQueueAttributeDefault = NVQueueAttributeSerial,
};

typedef NSUInteger NVQueueAttribute;


@interface NVQueue : NVObject

+ (id)globalQueueWithPriority: (NVQueuePriority)priority;

+ (id)mainQueue;

- (id)initWithLabel: (NSString *)label
          attribute: (NVQueueAttribute)attr;

- (NSString *)label;

@end


@interface NVQueue (Dispatch)

- (void)dispatchBlock: (NVBlock)block
          synchronize: (BOOL)flag;

- (void)dispatchFunction: (NVFunction)work
                 context: (void *)context
             synchronize: (BOOL)flag;

- (void)applyBlock: (NVIterationBlock)block
          forTimes: (size_t)times;

- (void)applyFunction: (NVIterationFunction)work
              context: (void *)context
             forTimes: (size_t)times;

- (void)dispatchBlock: (NVBlock)block
            afterTime: (dispatch_time_t)time;

- (void)dispatchFunction: (NVFunction)work
                 context: (void *)context
               afterTime: (dispatch_time_t)time;

- (void)dispatchBarrierBlock: (NVBlock)block
                 synchronize: (BOOL)flag;

- (void)dispatchBarrierFunction: (NVFunction)work
                        context: (void *)context
                    synchronize: (BOOL)flag;

@end

@interface NVQueue (Specific)

- (void)setContext: (void *)context
            forKey: (const void *)key
        destructor: (NVFunction)destructor;

- (void *)contextForKey: (const void *)key;

@end