//
//  NSFetchedResultsController+BTIAdditions.m
//  BTICoreDataKit
//
//  Created by Brian Slick in April 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTICoreDataKit
//

#import "NSFetchedResultsController+BTIAdditions.h"

#import "BTICoreDataKit.h"

@implementation NSFetchedResultsController (BTIAdditions)

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
