//
//  NSMutableArray+BTIKitAdditions.m
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "NSMutableArray+BTIKitAdditions.h"

// Models and other global
#import "BTIMacros.h"
#import "NSString+BTIKitAdditions.h"

@implementation NSMutableArray (BTIKitAdditions)

- (void)removeFirstObjectBTI
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
        
    if ([self count] > 0)
    {
        [self removeObjectAtIndex:0];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)moveObjectAtIndexBTI:(NSUInteger)fromIndex
                     toIndex:(NSUInteger)toIndex
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    id movingObject = [self objectAtIndex:fromIndex];
    
    [self removeObjectAtIndex:fromIndex];
    [self insertObject:movingObject atIndex:toIndex];

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)safelyAddPopulatedStringBTI:(NSString *)string
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    if (![string isKindOfClass:[NSString class]])
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Input is not a string", self, __PRETTY_FUNCTION__);
        return;
    }
    
    if (![string isNotEmptyBTI])
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - String is empty", self, __PRETTY_FUNCTION__);
        return;
    }
    
    [self addObject:string];

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
