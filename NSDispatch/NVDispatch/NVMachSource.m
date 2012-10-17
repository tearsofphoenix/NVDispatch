//
//  NVMachSource.m
//  NSDispatch
//
//  Created by tearsofphoenix on 7/27/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVMachSource.h"
#import "NVInternal.h"

@implementation NVMachSource

- (id)initWithMachPort: (mach_port_t)machPort
         sendOrReceive: (BOOL)isSend
                 queue: (NVQueue *)queue
{
    if ((self = [super init]))
    {
        if (isSend)
        {
            _obj = dispatch_source_create(DISPATCH_SOURCE_TYPE_MACH_SEND,
                                          machPort,
                                          DISPATCH_MACH_SEND_DEAD,
                                          _NVQueueGetQueue(queue));
        }else
        {
            _obj = dispatch_source_create(DISPATCH_SOURCE_TYPE_MACH_RECV,
                                          machPort,
                                          0,
                                          _NVQueueGetQueue(queue));
        }
    }
    
    return self;
}

- (mach_port_t)handle
{
    return dispatch_source_get_handle(_obj);
}

- (dispatch_source_mach_send_flags_t)data
{
    return dispatch_source_get_data(_obj);
}

- (dispatch_source_mach_send_flags_t)mask
{
    return dispatch_source_get_mask(_obj);
}

@end
