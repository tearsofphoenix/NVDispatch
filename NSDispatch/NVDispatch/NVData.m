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
#import <dispatch/dispatch.h>

@interface NVData ()
{
@private
    const void *_buffer;
    size_t _size;
}
@end

@implementation NVData

- (NSUInteger)size
{
    return dispatch_data_get_size(_obj);
}

@end

@implementation NVData (NVDataCreation)

dispatch_data_t _NVDataGetData(NVData *data)
{
    return data->_obj;
}

- (id)initWithData: (NSData *)data
           onQueue: (NVQueue *)queue
        destructor: (NVBlock)block
{
    if ((self = [super init]))
    {
        _obj = dispatch_data_create([data bytes], [data length], _NVQueueGetQueue(queue), block);
    }
    return self;
}

- (id)map
{
    const void *buffer = NULL;
    size_t size = 0;
    dispatch_data_t data = dispatch_data_create_map(_obj, &buffer, &size);

    NVData *result = [[[self class] alloc] init];
    result->_obj = data;
    result->_buffer = buffer;
    result->_size = size;
    
    return [result autorelease];
}

- (id)dataByConcatData: (NVData *)aData
{
    dispatch_data_t data = dispatch_data_create_concat(_obj, aData->_obj);
    
    NVData *result = [[[self class] alloc] init];
    result->_obj = data;
    
    return [result autorelease];
}

- (id)subDataWithRange: (NSRange)range
{
    dispatch_data_t data = dispatch_data_create_subrange(_obj, range.location, range.length);

    NVData *result = [[[self class] alloc] init];
    result->_obj = data;
    
    return [result autorelease];
}

- (BOOL)applyWithBlock: (dispatch_data_applier_t)block
{
    return dispatch_data_apply(_obj, block);
}

- (id)copyWithRegion: (NSUInteger)location
{
    size_t offset_ptr;
    
    dispatch_data_t data = dispatch_data_copy_region(_obj, location, &offset_ptr);
    
    NVData *result = [[[self class] alloc] init];
    result->_obj = data;
    
    return [result autorelease];
}

@end
