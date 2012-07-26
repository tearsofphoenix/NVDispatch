//
//  NVSource.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVDispatch.h"

@class NVQueue;

enum
{
    NVSourceTypeDataAdd,
    NVSourceTypeDataOr,
    NVSourceTypeMachSend,
    NVSourceTypeMachReceive,
    NVSourceTypeProcess,
    NVSourceTypeRead,
    NVSourceTypeSignal,
    NVSourceTypeTimer,
    NVSourceTypeVNode,
    NVSourceTypeWrite,
};

typedef NSUInteger NVSourceType;

@interface NVSource : NSObject

- (id)initWithSourceType: (NVSourceType)type
                   queue: (NVQueue *)queue;

- (void)setStartTime: (dispatch_time_t)start
            interval: (uint64_t)interval
              leeway: (uint64_t)leeway;

- (void)cancel;

- (NSUInteger)data;

- (uintptr_t)handle;

- (NSUInteger)mask;

- (void)mergeData: (NSUInteger)anotherData;

- (NSInteger)testCancel;

@end

@interface NVSource (setBlockAndFunction)

- (void)setRegistrationBlock: (NVBlock)block;
- (void)setRegistrationFunction: (NVFunction)work;

- (void)setCancelHandler: (NVBlock)block;
- (void)setCancelFunction: (NVFunction)work;

- (void)setEventHandler: (NVBlock)block;
- (void)setEventFunction: (NVFunction)work;

@end
