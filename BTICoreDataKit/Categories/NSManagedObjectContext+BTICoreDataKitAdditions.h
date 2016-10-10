//
//  BTICoreDataKit -- [https://github.com/BriTerIdeas/BTICoreDataKit]
//  v1.3
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

// Libraries
@import CoreData;

@interface NSManagedObjectContext (BTICoreDataKitAdditions)

/** Passes directly through to countForFetchRequest:error:
 */
- (NSUInteger)countForFetchRequestBTI:(NSFetchRequest *)fetchRequest;

/** Passes directly through to executeFetchRequest:error:
 */
- (NSArray *)executeFetchRequestBTI:(NSFetchRequest *)fetchRequest;

/** Passes directly through to save:
 */
- (BOOL)saveBTI;

@end
