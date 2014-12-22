//
//  NSNotificationCenter+BTIKitAdditions.m
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "NSNotificationCenter+BTIKitAdditions.h"

// Models and other global
#import "BTIMacros.h"

@implementation NSNotificationCenter (BTIKitAdditions)

- (void)postNotificationOnMainThreadBTI:(NSNotification *)notification
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if ([NSThread isMainThread])
    {
        [[NSNotificationCenter defaultCenter] postNotification:notification];
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
        });
    }

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)postNotificationNameOnMainThreadBTI:(NSString *)notificationName
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [self postNotificationNameOnMainThreadBTI:notificationName
                                       object:nil
                                     userInfo:nil];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)postNotificationNameOnMainThreadBTI:(NSString *)notificationName
                                   userInfo:(NSDictionary *)userInfo
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [self postNotificationNameOnMainThreadBTI:notificationName
                                       object:nil
                                     userInfo:userInfo];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)postNotificationNameOnMainThreadBTI:(NSString *)notificationName
                                     object:(id)object
                                   userInfo:(NSDictionary *)userInfo
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSNotification *notification = [NSNotification notificationWithName:notificationName
                                                                 object:object
                                                               userInfo:userInfo];
    
    [self postNotificationOnMainThreadBTI:notification];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
