//
//  NVObject.m
//  NSDispatch
//
//  Created by tearsofphoenix on 7/27/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVObject.h"

@implementation NVObject

#pragma mark - context

- (void *)context
{
    return dispatch_get_context(_obj);
}

- (void)setContext: (void *)context
{
    dispatch_set_context(_obj, context);
}

#pragma mark - retain & release

- (id)retain
{
    dispatch_retain(_obj);
    
    return [super retain];
}

- (oneway void)release
{
    dispatch_release(_obj);
    
    [super release];
}

#pragma mark - resume & suspend

- (void)resume
{
    dispatch_resume(_obj);
}

- (void)suspend
{
    dispatch_suspend(_obj);
}

- (void)setFinalizer: (NVFunction)finalizer
{
    dispatch_set_finalizer_f(_obj, finalizer);
}


@end
