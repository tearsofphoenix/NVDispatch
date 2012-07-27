//
//  NVSignalSource.m
//  NSDispatch
//
//  Created by tearsofphoenix on 7/27/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVSignalSource.h"
#import "NVInternal.h"

@implementation NVSignalSource

- (id)initWithSignalType: (int)signalType
                   queue: (NVQueue *)queue
{
    if ((self = [super init]))
    {
        _obj = dispatch_source_create(DISPATCH_SOURCE_TYPE_SIGNAL, signalType, 0, _NVQueueGetQueue(queue));
    }
    return self;
}

- (int)handle
{
    return dispatch_source_get_handle(_obj);
}

- (NSUInteger)data
{
    return dispatch_source_get_data(_obj);
}

@end
