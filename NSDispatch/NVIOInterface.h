//
//  NVIOInterface.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NVDispatch.h"

@class NVQueue;
@class NVData;

enum
{
    NVIOTypeStream = DISPATCH_IO_STREAM,
    NVIOTypeRandom = DISPATCH_IO_RANDOM,
};

typedef NSUInteger NVIOType;

@interface NVIOInterface : NSObject


- (id)initWithType: (NVIOType)type
           onQueue: (NVQueue *)queue
      errorHandler: (NVErrorHandleBlock)handler;

- (id)initWithType: (NVIOType)type
              path: (NSString *)path
              flag: (int)flag
              mode: (mode_t)mode
           onQueue: (NVQueue *)queue
      errorHandler: (NVErrorHandleBlock)handler;

- (void)readRange: (NSRange)range
          onQueue: (NVQueue *)queue
        withBlock: (dispatch_io_handler_t)block;

- (void)writeData: (NVData *)data
           offset: (NSUInteger)offset
          onQueue: (NVQueue *)queue
        withBlock: (dispatch_io_handler_t)block;

- (void)close;

- (void)setHighWater: (NSUInteger)hightWater;

- (void)setLowWater: (NSUInteger)lowWater;

- (void)setInterval: (NSUInteger)interval;

@end
