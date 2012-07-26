//
//  NVData.m
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVData.h"
#import "NVQueue.h"
#import "NVInternal.h"

@interface NVData ()
{
@private
    dispatch_data_t _data;
    const void *_buffer;
    size_t _size;
}
@end

@implementation NVData

- (NSUInteger)size
{
    return dispatch_data_get_size(_data);
}

@end

@implementation NVData (NVDataCreation)

dispatch_data_t _NVDataGetData(NVData *data)
{
    return data->_data;
}

- (id)initWithData: (NSData *)data
           onQueue: (NVQueue *)queue
        destructor: (NVBlock)block
{
    if ((self = [super init]))
    {
        _data = dispatch_data_create([data bytes], [data length], _NVQueueGetQueue(queue), block);
    }
    return self;
}

- (id)map
{
    const void *buffer = NULL;
    size_t size = 0;
    dispatch_data_t data = dispatch_data_create_map(_data, &buffer, &size);

    NVData *result = [[[self class] alloc] init];
    result->_data = data;
    result->_buffer = buffer;
    result->_size = size;
    
    return [result autorelease];
}

- (id)dataByConcatData: (NVData *)aData
{
    dispatch_data_t data = dispatch_data_create_concat(_data, aData->_data);
    
    NVData *result = [[[self class] alloc] init];
    result->_data = data;
    
    return [result autorelease];
}

- (id)subDataWithRange: (NSRange)range
{
    dispatch_data_t data = dispatch_data_create_subrange(_data, range.location, range.length);

    NVData *result = [[[self class] alloc] init];
    result->_data = data;
    
    return [result autorelease];
}

- (BOOL)applyWithBlock: (dispatch_data_applier_t)block
{
    return dispatch_data_apply(_data, block);
}

- (id)copyWithRegion: (NSUInteger)location
{
    size_t offset_ptr;
    
    dispatch_data_t data = dispatch_data_copy_region(_data, location, &offset_ptr);
    
    NVData *result = [[[self class] alloc] init];
    result->_data = data;
    
    return [result autorelease];
}


- (id)retain
{
    dispatch_retain(_data);
    return [super retain];
}

- (oneway void)release
{
    dispatch_release(_data);
    [super release];
}

@end
