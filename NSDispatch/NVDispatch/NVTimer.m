//
//  NVTimer.m
//  NSDispatch
//
//  Created by tearsofphoenix on 7/27/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVTimer.h"
#import "NVInternal.h"
#import "NVQueue.h"

@interface NVTimer ()
{
@private
    NSTimeInterval _timeInterval;
    BOOL _isValid;
    BOOL _repeat;
    dispatch_block_t _block;
}
@end

@implementation NVTimer

- (id)initWithQueue: (NVQueue *)queue
              block: (dispatch_block_t)block
           interval: (NSTimeInterval)ti
            repeats: (BOOL)rep
{
    if (_block)
    {
        
        _block = Block_copy(block);
        
        if ((self = [super init]))
        {
            _isValid = YES;
            _repeat = rep;
            
            _obj = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _NVQueueGetQueue(queue));
            dispatch_source_set_timer(_obj, dispatch_time(DISPATCH_TIME_NOW, ti * NSEC_PER_SEC), ti * NSEC_PER_SEC, 0);
            dispatch_source_set_event_handler(_obj, (^
                                                     {
                                                         _block();
                                                         if (!_repeat)
                                                         {
                                                             [self invalidate];
                                                         }
                                                     }));
            dispatch_resume(_obj);
        }
        return self;
    }
    return nil;
}

- (void)dealloc
{
    Block_release(_block);
    
    [super dealloc];
}

+ (NVTimer *)dispatchTimerWithQueue: (NVQueue *)queue
                              block: (dispatch_block_t)block
                           interval: (NSTimeInterval)ti
                            repeats: (BOOL)rep
{
    return [[[self alloc] initWithQueue: queue
                                 block: block
                              interval: ti
                                repeats: rep] autorelease];
}

+ (NVTimer *)dispatchTimerWithTimeInterval: (NSTimeInterval)ti
                                     block: (dispatch_block_t)block
                                   repeats: (BOOL)yesOrNo
{
    return [self dispatchTimerWithQueue: [NVQueue mainQueue]
                                  block: block
                               interval: ti
                                repeats: yesOrNo];
}

- (void)invalidate
{
    dispatch_source_cancel(_obj);
    _isValid = NO;
}

- (BOOL)isValid
{
    return _isValid;
}

- (NSTimeInterval)timeInterval
{
    return _timeInterval;
}

- (NSUInteger)data
{
    return dispatch_source_get_data(_obj);
}

@end
