//
//  NVIOInterface.m
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVIOInterface.h"
#import "NVQueue.h"
#import "NVData.h"
#import "NVInternal.h"

enum
{
    NVIOCloseFlagStop = DISPATCH_IO_STOP,
};

typedef NSUInteger NVIOCloseFlag;

enum
{
    NVIOChannelConfigurationStrictInterval = DISPATCH_IO_STRICT_INTERVAL,
};

typedef NSUInteger NVIOChannelConfiguration;

@interface NVIOInterface ()
{
@private
    dispatch_io_t _rawIO;
}
@end

@implementation NVIOInterface

- (void)dealloc
{
    [self close];
    
    [super dealloc];
}

- (id)initWithType: (NVIOType)type
           onQueue: (NVQueue *)queue
      errorHandler: (NVErrorHandleBlock)handler
{
    if ((self = [super init]))
    {
        _rawIO = dispatch_io_create(type, 0, _NVQueueGetQueue(queue), handler);
    }
    return self;
}

- (id)initWithType: (NVIOType)type
              path: (NSString *)path
              flag: (int)flag
              mode: (mode_t)mode
           onQueue: (NVQueue *)queue
      errorHandler: (NVErrorHandleBlock)handler
{
    if ((self = [super init]))
    {
        _rawIO = dispatch_io_create_with_path(type, [path UTF8String], flag, mode, _NVQueueGetQueue(queue), handler);
    }
    return self;
}

- (void)readRange: (NSRange)range
          onQueue: (NVQueue *)queue
        withBlock: (dispatch_io_handler_t)block
{
    dispatch_io_read(_rawIO, range.location, range.length, _NVQueueGetQueue(queue), block);
}

- (void)writeData: (NVData *)data
           offset: (NSUInteger)offset
          onQueue: (NVQueue *)queue
        withBlock: (dispatch_io_handler_t)block
{
    dispatch_io_write(_rawIO, offset, _NVDataGetData(data), _NVQueueGetQueue(queue), block);
}

- (void)close
{
    dispatch_io_close(_rawIO, NVIOCloseFlagStop);
}

- (void)setHighWater: (NSUInteger)hightWater
{
    dispatch_io_set_high_water(_rawIO, hightWater);
}

- (void)setLowWater: (NSUInteger)lowWater
{
    dispatch_io_set_low_water(_rawIO, lowWater);
}

- (void)setInterval: (NSUInteger)interval
{
    dispatch_io_set_interval(_rawIO, interval, NVIOChannelConfigurationStrictInterval);
}


- (id)retain
{
    dispatch_retain(_rawIO);
    return [super retain];
}

- (oneway void)release
{
    dispatch_release(_rawIO);
    [super release];
}

@end
