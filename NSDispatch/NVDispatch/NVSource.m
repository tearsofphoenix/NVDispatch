//
//  NVSource.m
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVSource.h"
#import "NVQueue.h"
#import "NVInternal.h"

@implementation NVSource

- (void)cancel
{
    dispatch_source_cancel(_obj);
}

- (void)mergeData: (NSUInteger)anotherData
{
    dispatch_source_merge_data(_obj, anotherData);
}

- (void)scheduleFromTime: (dispatch_time_t)start
                interval: (uint64_t)interval
                  leeway: (uint64_t)leeway
{
    dispatch_source_set_timer(_obj, start, interval, leeway);
}

- (NSInteger)testCancel
{
    return dispatch_source_testcancel(_obj);
}

@end

@implementation NVSource (setBlockAndFunction)

- (void)setRegistrationBlock: (NVBlock)block
{
    dispatch_source_set_registration_handler(_obj, block);
}

- (void)setRegistrationFunction: (NVFunction)work
{
    dispatch_source_set_registration_handler_f(_obj, work);
}

- (void)setCancelHandler: (NVBlock)block
{
    dispatch_source_set_cancel_handler(_obj, block);
}

- (void)setCancelFunction: (NVFunction)work
{
    dispatch_source_set_cancel_handler_f(_obj, work);
}

- (void)setEventHandler: (NVBlock)block
{
    dispatch_source_set_event_handler(_obj, block);
}

- (void)setEventFunction: (NVFunction)work
{
    dispatch_source_set_event_handler_f(_obj, work);
}

@end
