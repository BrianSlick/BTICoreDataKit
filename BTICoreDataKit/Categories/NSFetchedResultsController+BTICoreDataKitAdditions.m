//
//  BTICoreDataKit -- [https://github.com/BriTerIdeas/BTICoreDataKit]
//  v1.3
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "NSFetchedResultsController+BTICoreDataKitAdditions.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// Private Constants

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
