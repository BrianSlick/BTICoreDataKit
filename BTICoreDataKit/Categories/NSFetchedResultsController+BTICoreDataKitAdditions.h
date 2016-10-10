//
//  BTICoreDataKit -- [https://github.com/BriTerIdeas/BTICoreDataKit]
//  v1.3
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

// Libraries
@import CoreData;

// Classes and Forward Declarations

// Public Constants

// Protocols

@interface NSFetchedResultsController (BTICoreDataKitAdditions)

/** Passes directly through to performFetch:
 */
- (BOOL)performFetchBTI;

@end
