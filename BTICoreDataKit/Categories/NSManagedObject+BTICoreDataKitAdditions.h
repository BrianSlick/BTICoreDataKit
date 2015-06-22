//
//  BTICoreDataKit -- [https://github.com/BriTerIdeas/BTICoreDataKit]
//  v1.2
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

// Libraries
@import CoreData;

@interface NSManagedObject (BTICoreDataKitAdditions)

/**
 Returns an NSEntityDescription for with a name matching the class name.
 
 @param context The NSManagedObjectContext in which to search for the entity
 
 @return An NSEntityDescription matching the class name.
 */
+ (NSEntityDescription *)entityDescriptionInContextBTI:(NSManagedObjectContext *)context;

/**
 Returns a new instance of this NSManagedObject class in the specified context.
 Uses entityDescriptionInContextBTI:, so the class name and entity name need to match.
 
 @param context The NSManagedObjectContext in which to create the managed object

 @return A new managed object
 */
+ (instancetype)newManagedObjectInContextBTI:(NSManagedObjectContext *)context;

@end
