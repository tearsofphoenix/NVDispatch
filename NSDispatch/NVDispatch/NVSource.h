//
//  NVSource.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVObject.h"

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

@interface NVSource : NVObject

- (void)cancel;

- (NSInteger)testCancel;

- (void)mergeData: (NSUInteger)anotherData;

@end

@interface NVSource (setBlockAndFunction)

- (void)setRegistrationBlock: (NVBlock)block;
- (void)setRegistrationFunction: (NVFunction)work;

- (void)setCancelHandler: (NVBlock)block;
- (void)setCancelFunction: (NVFunction)work;

- (void)setEventHandler: (NVBlock)block;
- (void)setEventFunction: (NVFunction)work;

@end
