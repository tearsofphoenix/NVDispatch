//
//  NVDispatch.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef dispatch_block_t NVBlock;

typedef void (^ NVIterationBlock) (size_t);

typedef dispatch_function_t NVFunction;

typedef void (* NVIterationFunction)(void *, size_t);

typedef dispatch_queue_priority_t NVQueuePriority;

typedef void (^ NVErrorHandleBlock)(int error);

enum
{
    NVQueueAttributeSerial,
    NVQueueAttributeConcurrent,
};

typedef NSUInteger NVQueueAttribute;


@interface NVDispatch : NSObject

+ (void)executeBlockOnce: (NVBlock)block;

+ (void)executeFunctionOnce: (NVFunction)work
                    context: (void *)context;

@end
