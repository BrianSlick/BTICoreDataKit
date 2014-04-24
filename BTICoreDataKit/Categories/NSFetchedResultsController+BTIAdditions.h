//
//  NSFetchedResultsController+BTIAdditions.h
//  BTICoreDataKit
//
//  Created by Brian Slick in April 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTICoreDataKit
//

@import CoreData;

@interface NSFetchedResultsController (BTIAdditions)

/** Passes directly through to performFetch:
 */
- (BOOL)performFetchBTI;

@end
