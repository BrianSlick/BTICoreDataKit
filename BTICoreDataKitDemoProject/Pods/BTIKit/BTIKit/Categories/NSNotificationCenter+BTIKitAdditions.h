//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

// Libraries
#import <Foundation/Foundation.h>

@interface NSNotificationCenter (BTIKitAdditions)

/**
 Posts a notification on the main thread.
 
 @param notification The notification to be posted.
 */
- (void)postNotificationOnMainThreadBTI:(nullable NSNotification *)notification;

/**
 Posts a notification on the main thread. Parameters are passed through to a NSNotification object; refer to Apple documentation for specifics.
 
 @param notificationName The name for the new notification. May not be nil.
 */
- (void)postNotificationNameOnMainThreadBTI:(nullable NSString *)notificationName;

/**
 Posts a notification on the main thread. Parameters are passed through to a NSNotification object; refer to Apple documentation for specifics.
 
 @param notificationName The name for the new notification. May not be nil.
 @param userInfo The user information dictionary for the new notification. May be nil.
 */
- (void)postNotificationNameOnMainThreadBTI:(nullable NSString *)notificationName
                                   userInfo:(nullable NSDictionary *)userInfo;

/**
 Posts a notification on the main thread. Parameters are passed through to a NSNotification object; refer to Apple documentation for specifics.
 
 @param notificationName The name for the new notification. May not be nil.
 @param object The object for the new notification.
 @param userInfo The user information dictionary for the new notification. May be nil.
 */
- (void)postNotificationNameOnMainThreadBTI:(nullable NSString *)notificationName
                                     object:(nullable id)object
                                   userInfo:(nullable NSDictionary *)userInfo;

@end
