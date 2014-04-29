//
//  NSMutableArray+BTIKitAdditions.m
//  BTIKit
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "NSMutableArray+BTIKitAdditions.h"

#import "BTIKit.h"

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

@end
