//
//  NVFileSource.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/27/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVSource.h"

@interface NVFileSource : NVSource

- (id)initWithFilePath: (NSString *)filePath
           readOrWrite: (BOOL)readFlag
                 queue: (NVQueue *)queue;

- (int)handle;

- (NSUInteger)data;

@end
