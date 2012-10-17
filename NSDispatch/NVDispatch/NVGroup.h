//
//  NVGroup.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dispatch/group.h>

#import "NVObject.h"

@class NVQueue;

@interface NVGroup : NVObject

- (void)asynchronizeBlock: (NVBlock)block
                  toQueue: (NVQueue *)queue;

- (void)asynchronizeFunction: (NVFunction)work
                     context: (void *)context
                     toQueue: (NVQueue *)queue;

- (void)waitWithTimeOutInterval: (dispatch_time_t)timeout;

- (void)setNotifyBlockForCompletion: (NVBlock)block
                            toQueue: (NVQueue *)queue;

- (void)setNotifyFunctionForCompletion: (NVFunction)work
                               context: (void *)context
                               toQueue: (NVQueue *)queue;

- (void)enter;

- (void)leave;

@end
