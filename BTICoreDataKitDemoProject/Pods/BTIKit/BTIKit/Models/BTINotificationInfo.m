//
//  BTINotificationInfo.m
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "BTINotificationInfo.h"

// Models and other global
#import "BTIMacros.h"

@interface BTINotificationInfo ()

// Private Properties
@property (nonatomic, assign) BTINotificationInfoLifespan lifespan;

@property (nonatomic, weak) id observer;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, weak) id object;

@property (nonatomic, assign, getter = isBlockListener) BOOL blockListener;
@property (nonatomic, copy) id block;
@property (nonatomic, strong) id blockObserver;

@end

@implementation BTINotificationInfo

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Management


#pragma mark - Custom Getters and Setters


#pragma mark - Initialization

+ (instancetype)infoWithObserver:(id)observer
                        selector:(SEL)selector
                            name:(NSString *)name
                          object:(id)object
                        lifespan:(BTINotificationInfoLifespan)lifespan;
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    if (observer == nil)
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> BTINotificationInfo NOT created: No observer", self, __PRETTY_FUNCTION__);
        return nil;
    }
    
    if (selector == nil)
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> BTINotificationInfo NOT created: No selector", self, __PRETTY_FUNCTION__);
        return nil;
    }
    
    BTINotificationInfo *info = [[BTINotificationInfo alloc] init];
    
    [info setBlockListener:NO];
    
    [info setObserver:observer];
    [info setSelector:selector];
    [info setName:name];
    [info setObject:object];
    [info setLifespan:lifespan];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return info;
}

+ (instancetype)infoWithName:(NSString *)name
                      object:(id)object
                    lifespan:(BTINotificationInfoLifespan)lifespan
                  usingBlock:(void (^)(NSNotification *))block
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    if (block == nil)
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> BTINotificationInfo NOT created: No block", self, __PRETTY_FUNCTION__);
        return nil;
    }
    
    BTINotificationInfo *info = [[BTINotificationInfo alloc] init];

    [info setBlockListener:YES];
    
    [info setName:name];
    [info setObject:object];
    [info setLifespan:lifespan];
    [info setBlock:block];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return info;
}

#pragma mark - Misc Methods

- (void)startListening
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    if ([self isBlockListener])
    {
        id blockObserver = [notificationCenter addObserverForName:[self name]
                                                           object:[self object]
                                                            queue:nil
                                                       usingBlock:[self block]];
        [self setBlockObserver:blockObserver];
    }
    else
    {
        [notificationCenter addObserver:[self observer]
                               selector:[self selector]
                                   name:[self name]
                                 object:[self object]];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)stopListening
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
       
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    
    if ([self isBlockListener])
    {
        [notificationCenter removeObserver:[self blockObserver]];
        
        [self setBlockObserver:nil];
    }
    else
    {
        [notificationCenter removeObserver:[self observer]
                                      name:[self name]
                                    object:[self object]];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
