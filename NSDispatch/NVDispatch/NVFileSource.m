//
//  NVFileSource.m
//  NSDispatch
//
//  Created by tearsofphoenix on 7/27/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVFileSource.h"
#import "NVInternal.h"

@interface NVFileSource ()
{
@private
    uintptr_t _handle;
}
@end

@implementation NVFileSource

- (id)initWithFilePath: (NSString *)filePath
           readOrWrite: (BOOL)readFlag
                 queue: (NVQueue *)queue
{
    if (readFlag)
    {
        _obj = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ, _handle, 0, _NVQueueGetQueue(queue));
        
        _handle = open([filePath UTF8String], O_RDONLY);
        fcntl(_handle, F_SETFL, O_NONBLOCK);
    }else
    {
        _obj = dispatch_source_create(DISPATCH_SOURCE_TYPE_WRITE, _handle, 0, _NVQueueGetQueue(queue));
        
        _handle = open([filePath UTF8String], O_WRONLY);
        fcntl(_handle, F_SETFL);
    }
    
    if (!_obj)
    {
        close(_handle);
        return nil;
    }
    
    return self;
}


- (NSUInteger)data
{
    return dispatch_source_get_data(_obj);
}

- (int)handle
{
    return dispatch_source_get_handle(_obj);
}

@end
