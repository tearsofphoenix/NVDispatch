//
//  NSAppDelegate.m
//  NSDispatch
//
//  Created by tearsofphoenix on 7/25/12.
//  Copyright (c) 2012 tearsofphoenix. All rights reserved.
//

#import "NSAppDelegate.h"

#import <dispatch/dispatch.h>

@implementation NSAppDelegate

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    [_window setBackgroundColor: [UIColor whiteColor]];
    [_window makeKeyAndVisible];
    
    return YES;
}


@end
