//
//  NSFetchedResultsController+BTICoreDataKitAdditions.m
//  BTICoreDataKit
//  v1.1
//
//  Created by Brian Slick in April 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTICoreDataKit
//

#import "NSFetchedResultsController+BTICoreDataKitAdditions.h"

//#import "BTIMacros.h"

@implementation NSFetchedResultsController (BTICoreDataKitAdditions)

- (BOOL)performFetchBTI
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSError *error = nil;
    BOOL isFetchSuccessful = [self performFetch:&error];
    if (!isFetchSuccessful)
    {
        NSLog(@"BTI ERROR: Perform Fetch: %@", [error localizedDescription]);
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return isFetchSuccessful;
}

@end
