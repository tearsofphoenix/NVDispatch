//
//  NVNodeSource.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/27/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVSource.h"

enum
{
    NVNodeObserveTypeDelete = DISPATCH_VNODE_DELETE,
    NVNodeObserveTypeWrite = DISPATCH_VNODE_WRITE,
    NVNodeObserveTypeExtend = DISPATCH_VNODE_EXTEND,
    NVNodeObserveTypeAttribute = DISPATCH_VNODE_ATTRIB,
    NVNodeObserveTypeLink = DISPATCH_VNODE_LINK,
    NVNodeObserveTypeRename = DISPATCH_VNODE_RENAME,
    NVNodeObserveTypeRevoke = DISPATCH_VNODE_REVOKE,
};

typedef NSUInteger NVNodeObserveType;

@interface NVNodeSource : NVSource

- (id)initWithFilePath: (NSString *)filePath
           observeType: (NVNodeObserveType)type
                 queue: (NVQueue *)queue;

- (uintptr_t)handle;

- (dispatch_source_vnode_flags_t)mask;

- (dispatch_source_vnode_flags_t)data;

@end
