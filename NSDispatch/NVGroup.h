//
//  NVGroup.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dispatch/group.h>

#import "NVDispatch.h"

@class NVQueue;

@interface NVGroup : NSObject

- (void)addBlock: (NVBlock)block
         toQueue: (NVQueue *)queue;

- (void)addFunction: (NVFunction)work
            context: (void *)context
            toQueue: (NVQueue *)queue;
 
- (void)waitWithTimeOutInterval: (dispatch_time_t)timeout;

- (void)setCompletionBlock: (NVBlock)block
                   toQueue: (NVQueue *)queue;

- (void)setCompletionFunction: (NVFunction)work
                      context: (void *)context
                      toQueue: (NVQueue *)queue;

- (void)enter;

- (void)leave;

@end
