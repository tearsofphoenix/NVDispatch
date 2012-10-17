//
//  NVSignalSource.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/27/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVSource.h"

@interface NVSignalSource : NVSource

- (id)initWithSignalType: (int)signalType
                   queue: (NVQueue *)queue;

- (int)handle;

- (NSUInteger)data;

@end
