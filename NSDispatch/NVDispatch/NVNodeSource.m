//
//  NVNodeSource.m
//  NSDispatch
//
//  Created by tearsofphoenix on 7/27/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVNodeSource.h"
#import "NVInternal.h"

@interface NVNodeSource ()
{
@private
    uintptr_t _handle;
    NSString *_filePath;
}
@end

@implementation NVNodeSource

- (id)initWithFilePath: (NSString *)filePath
           observeType: (NVNodeObserveType)type
                 queue: (NVQueue *)queue
{
    if ((self = [super init]))
    {
        _filePath = [filePath retain];
        _handle = open([_filePath UTF8String], O_EVTONLY);
        _obj = dispatch_source_create(DISPATCH_SOURCE_TYPE_VNODE, _handle, type, _NVQueueGetQueue(queue));
 
    }
    
    return self;
}

- (void)dealloc
{
    [_filePath release];
    [super dealloc];
}

- (uintptr_t)handle
{
    return _handle;
}

- (dispatch_source_vnode_flags_t)mask
{
    return dispatch_source_get_mask(_obj);
}

- (dispatch_source_vnode_flags_t)data
{
    return dispatch_source_get_data(_obj);
}

@end
