//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "NSMutableArray+BTIKitAdditions.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories
#import "NSString+BTIKitAdditions.h"

// Models

// Private Constants

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

- (void)safelyAddPopulatedStringBTI:(nullable NSString *)string
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
