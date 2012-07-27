//
//  NVSemaphore.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "NVObject.h"

@interface NVSemaphore : NVObject

- (id)initWithCount: (NSInteger)count;

- (NSInteger)waitWithTimeOutInterval: (dispatch_time_t)timeout;

- (NSInteger)signal;

@end
