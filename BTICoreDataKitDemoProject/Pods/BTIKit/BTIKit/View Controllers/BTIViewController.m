//
//  BTIViewController.m
//  BTIKit
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "BTIViewController.h"

// Models and other global
#import "BTIKit.h"

// Sub-controllers

// Views

// Private Constants

@interface BTIViewController ()

// Private Properties
@property (nonatomic, strong) NSMutableSet *notificationInfos;

@end

@implementation BTIViewController

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Methods

- (void)dealloc
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [self stopListeningForAllNotifications];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)didReceiveMemoryWarning
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
       
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded])
    {
        if ([[self view] window] == nil)
        {
            [self setView:nil];
        }
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Initialization and UI Creation Methods

- (id)init
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    self = [self initWithNibName:nil
                          bundle:nil];
    if (self)
    {
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil
               bundle:(NSBundle *)nibBundleOrNil
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    if (self)
    {
        [self populateNotificationInfos];
        [self startListeningForNotificationsWithLifespan:BTINotificationInfoLifespanLifetime];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return self;
}

- (void)awakeFromNib
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [super awakeFromNib];
    
    [self populateNotificationInfos];
    [self startListeningForNotificationsWithLifespan:BTINotificationInfoLifespanLifetime];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Custom Getters and Setters

- (NSMutableSet *)notificationInfos
{
    if (_notificationInfos == nil)
    {
        _notificationInfos = [[NSMutableSet alloc] init];
    }
    return _notificationInfos;
}

#pragma mark - UIViewController Overrides

- (void)viewWillAppear:(BOOL)animated
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [super viewWillAppear:animated];
    
    [self startListeningForNotificationsWithLifespan:BTINotificationInfoLifespanVisible];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)viewWillDisappear:(BOOL)animated
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [super viewWillDisappear:animated];
    
    [self stopListeningForNotificationsWithLifespan:BTINotificationInfoLifespanVisible];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Notification Handlers


#pragma mark - UI Response Methods


#pragma mark - Misc Methods

- (void)populateContents;
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    // Deliberately empty.  Subclasses should override and call super
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTINotificationInfo Support Methods

- (void)populateNotificationInfos
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    // Subclasses should override and call super first
    
    for (BTINotificationInfo *info in [self notificationInfos])
    {
        [info stopListening];
    }
    
    [[self notificationInfos] removeAllObjects];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)addNotificationInfo:(BTINotificationInfo *)info
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (info != nil)
    {
        [[self notificationInfos] addObject:info];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)addLifetimeNotificationInfoForName:(NSString *)name
                                  selector:(SEL)selector
                                    object:(id)object
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    BTINotificationInfo *info = [BTINotificationInfo infoWithObserver:self
                                                             selector:selector
                                                                 name:name
                                                               object:object
                                                             lifespan:BTINotificationInfoLifespanLifetime];
    [self addNotificationInfo:info];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)addLifetimeNotificationInfoForName:(NSString *)name
                                    object:(id)object
                                usingBlock:(void (^)(NSNotification *notification))block
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    BTINotificationInfo *info = [BTINotificationInfo infoWithName:name
                                                           object:object
                                                         lifespan:BTINotificationInfoLifespanLifetime
                                                       usingBlock:block];
    [self addNotificationInfo:info];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)addVisibleNotificationInfoForName:(NSString *)name
                                 selector:(SEL)selector
                                   object:(id)object
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    BTINotificationInfo *info = [BTINotificationInfo infoWithObserver:self
                                                             selector:selector
                                                                 name:name
                                                               object:object
                                                             lifespan:BTINotificationInfoLifespanVisible];
    [self addNotificationInfo:info];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)addVisibleNotificationInfoForName:(NSString *)name
                                   object:(id)object
                               usingBlock:(void (^)(NSNotification *notification))block
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    BTINotificationInfo *info = [BTINotificationInfo infoWithName:name
                                                           object:object
                                                         lifespan:BTINotificationInfoLifespanVisible
                                                       usingBlock:block];
    [self addNotificationInfo:info];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)startListeningForNotificationsWithLifespan:(BTINotificationInfoLifespan)lifespan
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    for (BTINotificationInfo *info in [self notificationInfos])
    {
        if ([info lifespan] == lifespan)
        {
            [info startListening];
        }
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)stopListeningForNotificationsWithLifespan:(BTINotificationInfoLifespan)lifespan
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    for (BTINotificationInfo *info in [self notificationInfos])
    {
        if ([info lifespan] == lifespan)
        {
            [info stopListening];
        }
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)stopListeningForAllNotifications
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    for (BTINotificationInfo *info in [self notificationInfos])
    {
        [info stopListening];
    }

    [[NSNotificationCenter defaultCenter] removeObserver:self];

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
