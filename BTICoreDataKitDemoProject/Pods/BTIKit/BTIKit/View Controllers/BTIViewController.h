//
//  BTIViewController.h
//  BTIKit
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

/*
 
 OVERVIEW
 
 This is a view controller class intended to demonstrate a variety of concepts, including:
 
 - Just in case there are features that all view controllers in the project should have, it can be helpful to have an interim VC rather than always inheriting from UIViewController directly.  Even if this VC did nothing by itself, its presence can be handy later if universal customization becomes necessary.
 
 - init is overriden to call the UIViewController initializer.  This allows parent VC's to simply alloc/init, and not have to know or care about details like a) is it a plain view controller or a table view controller, b) does it even use a xib, and c) probably several other decisions that a parent VC has no business making.  View controllers should be self-sufficient, and providing a single initializer goes a long way towards acheiving that.  The scheme chosen assumes that *ViewController.h and *ViewController.m will always be accompanied by *ViewController.xib.  If you like naming your VC xibs as *View.xib, seriously, stop that.
 
 - A generic method - populateContents - is defined to provide a consistent place for updating the view contents.
 
 - Earlier iOS-style handling of view unloading in response to a memory warning.
 
 - The use of BTINotificationInfo.  A generic method - populateNotificationInfos - is defined for creating the helpers in one place.  This method should be overridden in subclasses, with a call to super happening first.  After that, simply create any helpers, and add them using the provided methods.  This class has been set up to automatically register 'lifetime' notifications in init, and handles 'visible' notifications in viewWill(Dis)Appear.
 
 - dealloc unregisters from all notifications
 
 */

// Libraries
#import <UIKit/UIKit.h>

// Forward Declarations and Classes
#import "BTINotificationInfo.h"

// Public Constants

// Protocols

@interface BTIViewController : UIViewController

#pragma mark - Public Properties


#pragma mark - Public Methods

/**
 Designated method for refreshing the UI.  Default implementation does nothing.  Subclasses should override and probably call super, though this is not required.
 This method is NOT called automatically under any circumstances.
 */
- (void)populateContents;

/**
 Designated method for defining BTINotificationInfo objects.  Subclasses should override and call super FIRST. Not last, not in the middle, FIRST.  This method will be automatically called, there probably shouldn't be a reason to call it manually.
 */
- (void)populateNotificationInfos NS_REQUIRES_SUPER;

#pragma mark BTINotificationHelper Support

/**
 Adds a notification info to the pool that is managed by the view controller.  Subclasses should not override this method.

 @param info A BTINotificationInfo object to be managed by this view controller.
 */
- (void)addNotificationInfo:(BTINotificationInfo *)info;

/**
 Shortcut method for addNotificationInfo: with predefined values, 'self' is the observer.  See BTINotificationInfo and NSNotificationCenter for value definitions.
 
 @param name The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer. 
 @param selector Selector that specifies the message the receiver sends notificationObserver to notify it of the notification posting. The method specified by notificationSelector must have one and only one argument (an instance of NSNotification).
 @param object The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer.
 */
- (void)addLifetimeNotificationInfoForName:(NSString *)name
                                  selector:(SEL)selector
                                    object:(id)object;

/**
 Shortcut method for addNotificationInfo: with predefined values.  See BTINotificationInfo and NSNotificationCenter for value definitions.
 
 @param name The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
 @param object The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer.
 @param block The block to be executed when the notification is received.
 */
- (void)addLifetimeNotificationInfoForName:(NSString *)name
                                    object:(id)object
                                usingBlock:(void (^)(NSNotification *notification))block;

/**
 Shortcut method for addNotificationInfo: with predefined values, 'self' is the observer.  See BTINotificationInfo and NSNotificationCenter for value definitions.
 
 @param name The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
 @param selector Selector that specifies the message the receiver sends notificationObserver to notify it of the notification posting. The method specified by notificationSelector must have one and only one argument (an instance of NSNotification).
 @param object The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer.
 */- (void)addVisibleNotificationInfoForName:(NSString *)name
                                 selector:(SEL)selector
                                   object:(id)object;

/**
 Shortcut method for addNotificationInfo: with predefined values.  See BTINotificationInfo and NSNotificationCenter for value definitions.
 
 @param name The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
 @param object The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer.
 @param block The block to be executed when the notification is received.
 */
- (void)addVisibleNotificationInfoForName:(NSString *)name
                                   object:(id)object
                               usingBlock:(void (^)(NSNotification *notification))block;

/**
 Registers all notifications with the specified lifespan.  Note that this class is already handling 'lifetime' and 'visible' notifications, so this method should probably only be used with custom lifespans.  Subclasses should not override this method.
 
 @param lifespan The lifespan for which listeners should be activated
 */
- (void)startListeningForNotificationsWithLifespan:(BTINotificationInfoLifespan)lifespan;

/**
 Unregisters all notifications with the specified lifespan.  Note that this class is already handling 'lifetime' and 'visible' notifications, so this method should probably only be used with custom lifespans.  Subclasses should not override this method.
 
 @param lifespan The lifespan for which listeners should be deactivated
 */
- (void)stopListeningForNotificationsWithLifespan:(BTINotificationInfoLifespan)lifespan;

@end
