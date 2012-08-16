//
//  NVTimerSource.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/27/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVSource.h"

@interface NVTimerSource : NVSource

- (id)initWithQueue: (NVQueue *)queue;

- (NSUInteger)data;

@end
