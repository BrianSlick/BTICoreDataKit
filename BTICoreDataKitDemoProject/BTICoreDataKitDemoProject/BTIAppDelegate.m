//
//  BTIAppDelegate.m
//  BTICoreDataKitDemoProject
//
//  Created by Brian Slick on 4/21/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import "BTIAppDelegate.h"

#import "BTIMacros.h"

#import "SampleTableViewController.h"

@implementation BTIAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    UIWindow *window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self setWindow:window];

    SampleTableViewController *tableViewController = [[SampleTableViewController alloc] init];
    
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:tableViewController];
    
    [window setRootViewController:navController];
    [window makeKeyAndVisible];

    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return YES;
}

@end
