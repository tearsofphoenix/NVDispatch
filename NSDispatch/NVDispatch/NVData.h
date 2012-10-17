//
//  NVData.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dispatch/data.h>
#import "NVObject.h"

@class NVQueue;

@interface NVData : NVObject

- (NSUInteger)size;

@end

@interface NVData (NVDataCreation)

- (id)initWithData: (NSData *)data
           onQueue: (NVQueue *)queue
        destructor: (NVBlock)block;

- (id)map;

- (id)dataByConcatData: (NVData *)aData;

- (id)subDataWithRange: (NSRange)range;

- (BOOL)applyWithBlock: (dispatch_data_applier_t)block;

- (id)copyWithRegion: (NSUInteger)location;

@end
