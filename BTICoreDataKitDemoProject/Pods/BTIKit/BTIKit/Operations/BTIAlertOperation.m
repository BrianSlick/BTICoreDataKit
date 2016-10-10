//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "BTIAlertOperation.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// Private Constants
NSString *const BTIAlertOperationExecutingKey = @"isExecuting";
NSString *const BTIAlertOperationFinishedKey = @"isFinished";

@interface BTIAlertOperation ()

// Private Properties
@property (nonnull, nonatomic, strong) UIAlertController *alertController;
@property (nullable, nonatomic, weak) UIViewController *presentationContext;

@property (getter = isPrivateExecuting) BOOL privateExecuting;
@property (getter = isPrivateFinished) BOOL privateFinished;

@end

@implementation BTIAlertOperation

#pragma mark - Custom Getters and Setters

- (nullable NSString *)title
{
    return [[self alertController] title];
}

- (void)setTitle:(nullable NSString *)title
{
    [[self alertController] setTitle:title];
    [self setName:title];
}

- (nullable NSString *)message
{
    return [[self alertController] message];
}

- (void)setMessage:(nullable NSString *)message
{
    [[self alertController] setMessage:message];
}

- (nonnull UIAlertController *)alertController
{
    if (_alertController == nil)
    {
        _alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleAlert];
    }
    return _alertController;
}

#pragma mark - Initialization

- (nonnull instancetype)initWithPresentationContext:(nullable UIViewController *)presentationContext
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    self = [super init];
    if (self)
    {
        [self setPresentationContext:presentationContext ?: [[[UIApplication sharedApplication] keyWindow] rootViewController]];
    }

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return self;
}

#pragma mark - NSOperation Overrides

- (BOOL)isAsynchronous
{
    return YES;
}

- (BOOL)isExecuting
{
    return _privateExecuting;
}

- (BOOL)isFinished
{
    return _privateFinished;
}

- (void)start
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    if ([self isCancelled])
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Operation Cancelled", self, __PRETTY_FUNCTION__);
        return;
    }
    
    if ([self presentationContext] == nil)
    {
        [self finish];
        
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - No presentation context is available", self, __PRETTY_FUNCTION__);
        return;
    }
    
    [self willChangeValueForKey:BTIAlertOperationExecutingKey];
    [self setPrivateExecuting:YES];
    [self didChangeValueForKey:BTIAlertOperationExecutingKey];

    __weak BTIAlertOperation *weakSelf = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
       
        if ([[[weakSelf alertController] actions] count] == 0)
        {
            [weakSelf addActionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        }
        
        [[weakSelf presentationContext] presentViewController:[weakSelf alertController] animated:YES completion:nil];
        
    });

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Misc Methods

- (void)addActionWithTitle:(nullable NSString *)title
                     style:(UIAlertActionStyle)style
                   handler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    __weak BTIAlertOperation *weakSelf = self;
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:title
                                                     style:style
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                       
                                                       if (handler != nil)
                                                       {
                                                           handler(action);
                                                       }
                                                       
                                                       [weakSelf finish];
                                                       
                                                   }];
    
    [[self alertController] addAction:action];

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)finish
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    [self willChangeValueForKey:BTIAlertOperationExecutingKey];
    [self willChangeValueForKey:BTIAlertOperationFinishedKey];
    
    [self setPrivateExecuting:NO];
    [self setPrivateFinished:YES];
    
    [self didChangeValueForKey:BTIAlertOperationExecutingKey];
    [self didChangeValueForKey:BTIAlertOperationFinishedKey];

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
