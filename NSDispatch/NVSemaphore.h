//
//  NVSemaphore.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NVSemaphore : NSObject

- (id)initWithCount: (NSInteger)count;

- (NSInteger)waitWithTimeOutInterval: (dispatch_time_t)timeout;

- (NSInteger)signal;

@end
