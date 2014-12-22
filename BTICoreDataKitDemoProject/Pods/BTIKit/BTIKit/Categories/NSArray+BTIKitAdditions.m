//
//  NSArray+BTIKitAdditions.m
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in August 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "NSArray+BTIKitAdditions.h"

// Models and other global
#import "BTIMacros.h"

// Private Constants

@implementation NSArray (BTIKitAdditions)

- (id)objectAtRandomIndexBTI
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    NSInteger index = arc4random() % [self count];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [self objectAtIndex:index];
}

@end
