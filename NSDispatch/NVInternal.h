//
//  NVInternal.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dispatch/dispatch.h>

@class NVQueue;
@class NVData;

extern dispatch_queue_t _NVQueueGetQueue(NVQueue * queue);

extern dispatch_data_t _NVDataGetData(NVData *data);