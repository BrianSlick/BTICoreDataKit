//
//  NSNotificationCenter+BTIAdditions.h
//  BTIKit
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import <Foundation/Foundation.h>

@interface NSNotificationCenter (BTIAdditions)

/**
 Posts a notification on the main thread. Parameters are passed through to a NSNotification object; refer to Apple documentation for specifics.
 
 @param notificationName The name for the new notification. May not be nil.
 */
- (void)postNotificationNameOnMainThreadBTI:(NSString *)notificationName;

/**
 Posts a notification on the main thread. Parameters are passed through to a NSNotification object; refer to Apple documentation for specifics.
 
 @param notificationName The name for the new notification. May not be nil.
 @param userInfo The user information dictionary for the new notification. May be nil.
 */
- (void)postNotificationNameOnMainThreadBTI:(NSString *)notificationName
                                   userInfo:(NSDictionary *)userInfo;

/**
 Posts a notification on the main thread. Parameters are passed through to a NSNotification object; refer to Apple documentation for specifics.
 
 @param notificationName The name for the new notification. May not be nil. 
 @param object The object for the new notification.
 @param userInfo The user information dictionary for the new notification. May be nil.
 */
- (void)postNotificationNameOnMainThreadBTI:(NSString *)notificationName
                                     object:(id)object
                                   userInfo:(NSDictionary *)userInfo;

@end