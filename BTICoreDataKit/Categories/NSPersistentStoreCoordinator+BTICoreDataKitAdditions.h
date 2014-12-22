//
//  NSPersistentStoreCoordinator+BTICoreDataKitAdditions.h
//  BTICoreDataKit
//  v1.1
//
//  Created by Brian Slick in April 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTICoreDataKit
//

// Libraries
@import CoreData;

@interface NSPersistentStoreCoordinator (BTICoreDataKitAdditions)

/** Passes directly through to addPersistentStoreWithType:configuration:URL:options:error:
 */
- (NSPersistentStore *)addPersistentStoreWithTypeBTI:(NSString *)storeType configuration:(NSString *)configuration URL:(NSURL *)storeURL options:(NSDictionary *)options;

/** Passes directly through to removePersistentStore:error:
 */
- (BOOL)removePersistentStoreBTI:(NSPersistentStore *)store;

@end
