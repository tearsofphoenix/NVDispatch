//
//  NVDispatch.m
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVDispatch.h"

@implementation NVDispatch

//FIXME
//
+ (void)executeBlockOnce: (NVBlock)block
{
    dispatch_once_t onceToken;
    dispatch_once(&onceToken, block);
}

//FIXME
//
+ (void)executeFunctionOnce: (NVFunction)work
                    context: (void *)context
{
    dispatch_once_t onceToken;
    dispatch_once_f(&onceToken, context, work);
}

@end
