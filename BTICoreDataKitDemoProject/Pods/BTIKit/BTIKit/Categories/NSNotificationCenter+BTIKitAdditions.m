//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "NSNotificationCenter+BTIKitAdditions.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// Private Constants

@implementation NSNotificationCenter (BTIKitAdditions)

- (void)postNotificationOnMainThreadBTI:(nullable NSNotification *)notification
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (notification == nil)
    {
        return;
    }
    
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

- (void)postNotificationNameOnMainThreadBTI:(nullable NSString *)notificationName
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [self postNotificationNameOnMainThreadBTI:notificationName
                                       object:nil
                                     userInfo:nil];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)postNotificationNameOnMainThreadBTI:(nullable NSString *)notificationName
                                   userInfo:(nullable NSDictionary *)userInfo
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [self postNotificationNameOnMainThreadBTI:notificationName
                                       object:nil
                                     userInfo:userInfo];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)postNotificationNameOnMainThreadBTI:(nullable NSString *)notificationName
                                     object:(nullable id)object
                                   userInfo:(nullable NSDictionary *)userInfo
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (notificationName == nil)
    {
        return;
    }
    
    NSNotification *notification = [NSNotification notificationWithName:notificationName
                                                                 object:object
                                                               userInfo:userInfo];
    
    [self postNotificationOnMainThreadBTI:notification];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
