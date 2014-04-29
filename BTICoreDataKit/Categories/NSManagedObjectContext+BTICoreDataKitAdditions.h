//
//  NSManagedObjectContext+BTICoreDataKitAdditions.h
//  BTICoreDataKit
//
//  Created by Brian Slick in April 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTICoreDataKit
//

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
