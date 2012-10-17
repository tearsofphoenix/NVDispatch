//
//  NVMachSource.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/27/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVSource.h"

@interface NVMachSource : NVSource

- (id)initWithMachPort: (mach_port_t)machPort
         sendOrReceive: (BOOL)isSend
                 queue: (NVQueue *)queue;

- (mach_port_t)handle;

- (dispatch_source_mach_send_flags_t)data;

- (dispatch_source_mach_send_flags_t)mask;

@end
