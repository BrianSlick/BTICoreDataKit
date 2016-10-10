//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 Notification handling can involve a fair amount of... duplication isn't the right word... repetition of code.
 Ex: to register:
 [[NSNotificationCenter defaultCenter] addObserver:whoever selector:@selector(theMethod) name:ATypicallyLongStringConstant object:whatever];
 To unregister:
 [[NSNotificationCenter defaultCenter] removeObserver:whoever name:ATypicallyLongStringConstant object:whatever];
 
 So it's not duplication in the sense of being copy-pasteable, but the elements of these methods are quite similar.  The combo of observer/name/object needs to be preserved in 2 places, which increases the opportunity for errors.
 
 This class attempts to remove that duplication.  A single helper is populated with observer/name/object one time, in one place, and can then be registered or unregistered easily, multiple times if necessary, by simply calling the appropriate method on that helper.
 
 This class is not intended to be standalone (though it can be used anywhere that notifications are), but instead used in concert with a view controller. The intention is to define ALL helpers in one place.  Since different notifications may have different life spans - for example, they should only respond when the view controller's view is visible, or they should respond during the entire lifetime of the view controller, the lifespan parameter is provided to enable this behavior, and also serve as documentation.  This avoids having to define some notifications in init, others in viewWillAppear, and then possibly having separate unregistration code in viewWillDisappear as well.  This reduces code, improves readability and discoverability, and makes the design intent of these notifications much clearer.
 
 */

// Libraries

// Classes and Forward Declarations
#import "BTIObject.h"

// Public Constants

// Protocols

typedef NS_ENUM(NSInteger, BTINotificationInfoLifespan) {
    BTINotificationInfoLifespanLifetime = 1,        // The observer should listen for its entire lifetime
    BTINotificationInfoLifespanVisible,             // The observer should only listen when it is on screen
    BTINotificationInfoLifespanCustom,              // No specific behavior implied
};

@interface BTINotificationInfo : BTIObject

#pragma mark - Properties

/// Indicates how long the observer, typically a view controller, should listen for the designated notification.
@property (nonatomic, assign, readonly) BTINotificationInfoLifespan lifespan;

#pragma mark - Methods

/**
 Creates and returns a new BTINotificationInfo object to manage the provided notification parameters.
 
 Most values are passed straight through to NSNotificationCenter, so refer to Apple documentation for specifics.  lifeSpan is a constant (declared above) that defines when this notification should be registered. This class does not use this value directly.  It is up to other classes, specifically view controllers, to make use of the property.  The intention is that "Lifetime" would be registered for the life of the observing object, and that "Visible" would be registered only when that view controller's view is on screen.
 
 @param observer Object registering as an observer. This value must not be nil.
 @param selector Selector that specifies the message the receiver sends \em observer to notify it of the notification posting. The method specified by \em selector must have one and only one argument (an instance of NSNotification).
 @param name The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
 @param object The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer.
 @param lifespan The amount of time the listener should be active
 
 @return A configured BTINotificationInfo object
 
 */
+ (nullable instancetype)infoWithObserver:(nullable id)observer
                                 selector:(nullable SEL)selector
                                     name:(nullable NSString *)name
                                   object:(nullable id)object
                                 lifespan:(BTINotificationInfoLifespan)lifespan;

/**
 Creates and returns a new BTINotificationInfo object to manage the provided notification parameters.
 
 Most values are passed straight through to NSNotificationCenter, so refer to Apple documentation for specifics.  lifeSpan is a constant (declared above) that defines when this notification should be registered. This class does not use this value directly.  It is up to other classes, specifically view controllers, to make use of the property.  The intention is that "Lifetime" would be registered for the life of the observing object, and that "Visible" would be registered only when that view controller's view is on screen.
 
 @param name The name of the notification for which to register the observer; that is, only notifications with this name are delivered to the observer.
 @param object The object whose notifications the observer wants to receive; that is, only notifications sent by this sender are delivered to the observer.
 @param lifespan The amount of time the listener should be active
 @param block The block to be executed when the notification is received.
 
 @return A configured BTINotificationInfo object
 
 */
+ (nullable instancetype)infoWithName:(nullable NSString *)name
                               object:(nullable id)object
                             lifespan:(BTINotificationInfoLifespan)lifespan
                           usingBlock:(nullable void (^)(NSNotification * _Nonnull notification))block;

/**
 Calling this method will add the corresponding observer/selector/name/object to NSNotificationCenter
 */
- (void)startListening;

/**
 Calling this method will remove the corresponding observer/name/object from NSNotificationCenter
 */
- (void)stopListening;

@end
