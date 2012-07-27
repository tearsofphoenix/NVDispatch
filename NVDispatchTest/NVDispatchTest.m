//
//  NVDispatchTest.m
//  NVDispatchTest
//
//  Created by tearsofphoenix on 7/27/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NVDispatchTest.h"

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/errno.h>
#include <assert.h>
#include <dispatch/dispatch.h>
#include <mach/mach_time.h>
#import <libkern/OSAtomic.h>

#import "NVDispatch.h"

#define kIT	10

uint64_t		elapsed_time;

void	timer_start()
{
    elapsed_time = mach_absolute_time();
}

double	timer_milePost()
{
	static dispatch_once_t		justOnce;
	static double		scale;
	
	dispatch_once(&justOnce, (^
                              {
                                  mach_timebase_info_data_t	tbi;
                                  mach_timebase_info(&tbi);
                                  scale = tbi.numer;
                                  scale = scale/tbi.denom;
                                  printf("Scale is %10.4f  Just computed once courtesy of dispatch_once()\n", scale);
                              }));
	
	uint64_t	now = mach_absolute_time() - elapsed_time;
    
	double	fTotalT = now;
	fTotalT = fTotalT * scale;			// convert this to nanoseconds...
	fTotalT = fTotalT / 1000000000.0;
	
    return fTotalT;
}


@implementation NVDispatchTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testApply
{
    NVQueue *queue = [[NVQueue alloc] initWithLabel: @"myQueue"
                                          attribute: NVQueueAttributeSerial];
    NVGroup *group = [[NVGroup alloc] init];
    
    // dispatch_apply on a serial queue finishes each block in order so the following code will take a little more than a second
	timer_start();
    [queue applyBlock: (^(size_t current)
                        {
                            printf("Block #%ld of %d is being run\n",
                                   current+1, // adjusting the zero based current iteration we get passed in
                                   kIT);
                            usleep(USEC_PER_SEC/10);
                        })
             forTimes: kIT];
    
	printf("and dispatch_apply( serial queue ) returned after %10.4lf seconds\n",timer_milePost());
	
    // dispatch_apply on a concurrent queue returns after all blocks are finished, however it can execute them concurrently with each other
    // so this will take quite a bit less time
	timer_start();
    
    NVQueue *globalQueue = [NVQueue globalQueueWithPriority: NVQueuePriorityDefault];
    [globalQueue applyBlock: (^(size_t current)
                              {
                                  printf("Block #%ld of %d is being run\n",current+1, kIT);
                                  usleep(USEC_PER_SEC/10);
                              })
                   forTimes: kIT];
    
	printf("and dispatch_apply( concurrent queue) returned after %10.4lf seconds\n",timer_milePost());
	
    // To execute all blocks in a dispatch_apply asynchonously, you will need to perform the dispatch_apply
    // asynchonously, like this (NOTE the nested dispatch_apply inside of the async block.)
    // Also note the use of the dispatch_group so that we can ultimatly know when the work is
    // all completed
	
	timer_start();
    [group asynchronizeBlock: (^
                      {
                          [queue applyBlock: (^(size_t current)
                                              {
                                                  printf("Block #%ld of %d is being run\n",current+1, kIT);
                                                  usleep(USEC_PER_SEC/10);
                                              })
                                   forTimes: kIT];
                      })
            toQueue: globalQueue];
	
	printf("and dispatch_group_async( dispatch_apply( )) returned after %10.4lf seconds\n",timer_milePost());
	printf("Now to wait for the dispatch group to finish...\n");
    
    [group waitWithTimeOutInterval: UINT64_MAX];
	
    printf("and we are done with dispatch_group_async( dispatch_apply( )) after %10.4lf seconds\n",timer_milePost());
    
    [queue release];
    [group release];
}

- (void)testTimer
{
    NVQueue *timerQueue = [[NVQueue alloc] initWithLabel: @"timer queue"
                                               attribute: NVQueueAttributeDefault];
    
    NVTimerSource *source = [[NVTimerSource alloc] initWithQueue: timerQueue];
    
    __block int i = 0;
    
    printf("Starting to count by seconds\n");
    
    [source setEventHandler: (^
                              {
                                  printf("%d\n", ++i);
                                  if (i >= 6)
                                  {
                                      printf("i > 6\n");
                                      [source cancel];
                                  }
                                  
                                  if (i == 3)
                                  {
                                      printf("switching to half seconds\n");
                                      
                                      [source scheduleFromTime: DISPATCH_TIME_NOW
                                                      interval: NSEC_PER_SEC / 2
                                                        leeway: 0];
                                  }
                              })];
    
	[source setCancelHandler: (^
                               {
                                   printf("dispatch source canceled OK\n");
                                   [source release];
                                   exit(0);
                                   
                               })];
    
    [source scheduleFromTime: dispatch_time(DISPATCH_TIME_NOW,NSEC_PER_SEC)
                    interval: NSEC_PER_SEC
                      leeway: 0];
    
    [source resume];
	dispatch_main();
}

- (void)testNWide
{
    NVGroup	*mg = [[NVGroup alloc] init];
    
	__block int numRunning = 0;
	
    int	qWidth = 5;
	
    int numWorkBlocks = 100;
	
	printf("Starting dispatch semaphore test to simulate a %d wide dispatch queue\n", qWidth );
    NVSemaphore *ds = [[NVSemaphore alloc] initWithCount: qWidth];
	
	for (int i=0; i<numWorkBlocks; i++)
    {
		// synchronize the whole shebang every 25 work units...
		if (i % 25 == 24)
        {
            [mg asynchronizeBlock: (^
                           {
                               // wait for all pending work units to finish up...
                               for (int x=0; x<qWidth; x++)
                               {
                                   [ds waitWithTimeOutInterval: DISPATCH_TIME_FOREVER];
                               }
                               // do the thing that is critical here
                               printf("doing something critical...while %d work units are running \n",numRunning);
                               // and let work continue unimpeeded
                               for (int x=0; x<qWidth; x++)
                               {
                                   [ds signal];
                               }
                           })
                 toQueue: [NVQueue globalQueueWithPriority: NVQueuePriorityDefault]];
            
		} else
        {
			// schedule the next block waiting when there are qWidth blocks running
            [ds waitWithTimeOutInterval: DISPATCH_TIME_FOREVER];
            [mg asynchronizeBlock: (^
                           {
                               OSAtomicIncrement32( &numRunning );
                               usleep(random() % 10000);	// simulate some random amount of work
                               printf("Value of i is %d  Number of blocks in flight %d\n",i, numRunning);
                               // tell the loop it's time to schedule the next block if there is one
                               OSAtomicDecrement32( &numRunning );
                               [ds signal];
                           })
                 toQueue:[NVQueue globalQueueWithPriority: NVQueuePriorityDefault]];
            
		}
	}
    
    [mg setNotifyBlockForCompletion: (^
                             {
                                 printf("And we are done!\n");
                                 [mg release];
                                 [ds release];
                                 exit(0);
                             })
                   toQueue: [NVQueue globalQueueWithPriority: NVQueuePriorityDefault]];
    
	dispatch_main();
}

@end
