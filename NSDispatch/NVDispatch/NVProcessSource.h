//
//  NVProcessSource.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/27/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVSource.h"

enum
{
    NVProcessObserveTypeExecute = DISPATCH_PROC_EXEC,
    NVProcessObserveTypeExit = DISPATCH_PROC_EXIT,
    NVProcessObserveTypeFork = DISPATCH_PROC_FORK,
    NVProcessObserveTypeSignal = DISPATCH_PROC_SIGNAL,
};

typedef NSUInteger NVProcessObserveType;

@interface NVProcessSource : NVSource

- (id)initWithPid: (pid_t)pid
      observeType: (NVProcessObserveType)type
            queue: (NVQueue *)queue;

- (pid_t)handle;

- (dispatch_source_proc_flags_t)mask;

- (dispatch_source_proc_flags_t)data;

@end
