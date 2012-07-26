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

@interface NVSource ()
{
@private
    dispatch_source_t _source;
}
@end

@implementation NVSource

- (id)initWithSourceType: (NVSourceType)type
                   queue: (NVQueue *)queue
{
    if ((self = [super init]))
    {
        dispatch_source_type_t sourceType = NULL;
        switch (type)
        {
            case NVSourceTypeDataAdd:
            {
                sourceType = DISPATCH_SOURCE_TYPE_DATA_ADD;
                break;
            }
            case NVSourceTypeDataOr:
            {
                sourceType = DISPATCH_SOURCE_TYPE_DATA_OR;
                break;
            }
            case NVSourceTypeMachSend:
            {
                sourceType = DISPATCH_SOURCE_TYPE_MACH_SEND;
                break;
            }
            case NVSourceTypeMachReceive:
            {
                sourceType = DISPATCH_SOURCE_TYPE_MACH_RECV;
                break;
            }
            case NVSourceTypeProcess:
            {
                sourceType = DISPATCH_SOURCE_TYPE_PROC;
                break;
            }
            case NVSourceTypeRead:
            {
                sourceType = DISPATCH_SOURCE_TYPE_READ;
                break;
            }
            case NVSourceTypeSignal:
            {
                sourceType = DISPATCH_SOURCE_TYPE_SIGNAL;
                break;
            }
            case NVSourceTypeTimer:
            {
                sourceType = DISPATCH_SOURCE_TYPE_TIMER;
                break;
            }
            case NVSourceTypeVNode:
            {
                sourceType = DISPATCH_SOURCE_TYPE_VNODE;
                break;
            }
            case NVSourceTypeWrite:
            {
                sourceType = DISPATCH_SOURCE_TYPE_WRITE;
                break;
            }
            default:
            {
                break;
            }
        }
        
        _source = dispatch_source_create(sourceType, 0, 0, _NVQueueGetQueue(queue));
    }
    
    return self;
}

- (void)cancel
{
    dispatch_source_cancel(_source);
}

- (NSUInteger)data
{
    return dispatch_source_get_data(_source);
}

- (uintptr_t)handle
{
    return dispatch_source_get_handle(_source);
}

- (NSUInteger)mask
{
    return dispatch_source_get_mask(_source);
}

- (void)mergeData: (NSUInteger)anotherData
{
    dispatch_source_merge_data(_source, anotherData);
}

- (void)setStartTime: (dispatch_time_t)start
            interval: (uint64_t)interval
              leeway: (uint64_t)leeway
{
    dispatch_source_set_timer(_source, start, interval, leeway);
}

- (NSInteger)testCancel
{
    return dispatch_source_testcancel(_source);
}

@end

@implementation NVSource (setBlockAndFunction)

- (void)setRegistrationBlock: (NVBlock)block
{
    dispatch_source_set_registration_handler(_source, block);
}

- (void)setRegistrationFunction: (NVFunction)work
{
    dispatch_source_set_registration_handler_f(_source, work);
}

- (void)setCancelHandler: (NVBlock)block
{
    dispatch_source_set_cancel_handler(_source, block);
}

- (void)setCancelFunction: (NVFunction)work
{
    dispatch_source_set_cancel_handler_f(_source, work);
}

- (void)setEventHandler: (NVBlock)block
{
    dispatch_source_set_event_handler(_source, block);
}

- (void)setEventFunction: (NVFunction)work
{
    dispatch_source_set_event_handler_f(_source, work);
}


- (id)retain
{
    dispatch_retain(_source);
    return [super retain];
}

- (oneway void)release
{
    dispatch_release(_source);
    [super release];
}

@end
