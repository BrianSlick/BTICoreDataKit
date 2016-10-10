//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "BTIAlertManager.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// Private Constants

@interface BTIAlertManager ()

// Private Properties
@property (nonnull, nonatomic, strong) NSOperationQueue *operationQueue;

@end

@implementation BTIAlertManager

#pragma mark - Custom Getters and Setters

- (nonnull NSOperationQueue *)operationQueue
{
    if (_operationQueue == nil)
    {
        _operationQueue = [[NSOperationQueue alloc] init];
        [_operationQueue setMaxConcurrentOperationCount:1];
    }
    return _operationQueue;
}

#pragma mark - Misc Methods

- (void)addAlertOperation:(nullable BTIAlertOperation *)alertOperation
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    if (alertOperation == nil)
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - No alert provided", self, __PRETTY_FUNCTION__);
        return;
    }
    
    [[self operationQueue] addOperation:alertOperation];

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Singleton

+ (nonnull instancetype)sharedManager
{
    static dispatch_once_t predicate;
    static BTIAlertManager *shared = nil;
    
    dispatch_once(&predicate, ^{
        
        shared = [[[self class] alloc] init];
        
    });
    
    return shared;
}

@end
