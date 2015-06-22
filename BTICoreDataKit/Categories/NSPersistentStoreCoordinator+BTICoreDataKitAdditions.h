//
//  BTICoreDataKit -- [https://github.com/BriTerIdeas/BTICoreDataKit]
//  v1.2
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
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
