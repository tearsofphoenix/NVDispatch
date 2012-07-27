//
//  NVDispatchTypes.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/27/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import <dispatch/dispatch.h>

typedef dispatch_block_t NVBlock;

typedef void (^ NVIterationBlock) (size_t);

typedef dispatch_function_t NVFunction;

typedef void (* NVIterationFunction)(void *, size_t);

typedef dispatch_queue_priority_t NVQueuePriority;

typedef void (^ NVErrorHandleBlock)(int error);
