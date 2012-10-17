//
//  NVObject.h
//  NSDispatch
//
//  Created by tearsofphoenix on 7/27/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NVDispatchTypes.h"

@interface NVObject : NSObject
{
@protected
    void *_obj;
}

- (void *)context;

- (void)setContext: (void *)context;

- (void)resume;

- (void)suspend;

- (void)setFinalizer: (NVFunction)finalizer;

@end
