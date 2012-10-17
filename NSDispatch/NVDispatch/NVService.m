//
//  NVService.m
//  NSDispatch
//
//  Created by LeixSnake on 10/17/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVService.h"

@interface NVService ()
{
@private
    NSOperationQueue *_queue;
    NSRunLoop *_runLoop;
}
@end

@implementation NVService

- (id)init
{
    if ((self = [super init]))
    {
        _queue = [[NSOperationQueue alloc] init];
        _runLoop = [[NSRunLoop alloc] init];
    }
    
    return self;
}

- (void)addBlock: (dispatch_block_t)block
{
    [self addBlock: block
        completion: nil];
}

- (void)addBlock: (dispatch_block_t)block
      completion: (dispatch_block_t)completion
{
    NSBlockOperation *blockOperation = [[NSBlockOperation alloc] init];
    
    [blockOperation addExecutionBlock: block];
    
    [blockOperation setCompletionBlock: block];
    
    [_queue addOperation: blockOperation];
    
    [blockOperation release];
}

- (void)_run
{
    while (YES)
    {
        @autoreleasepool
        {
            @try
            {
                [_runLoop runUntilDate: [NSDate dateWithTimeIntervalSinceNow: 0.1]];
            }
            @catch (NSException *exception)
            {
                NSLog(@"excepetion: %@ %@", exception, [exception callStackSymbols]);
            }
            @finally
            {

            }
        }
    }
}

@end
