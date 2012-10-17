//
//  NVTimer.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/27/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVSource.h"

@interface NVTimer : NVSource

+ (NVTimer *)dispatchTimerWithQueue: (NVQueue *)queue
                              block: (dispatch_block_t)block
                           interval: (NSTimeInterval)ti
                            repeats: (BOOL)rep;

+ (NVTimer *)dispatchTimerWithTimeInterval: (NSTimeInterval)ti
                                     block: (dispatch_block_t)block
                                   repeats: (BOOL)yesOrNo;

- (NSTimeInterval)timeInterval;

- (void)invalidate;
- (BOOL)isValid;

- (NSUInteger)data;

@end
