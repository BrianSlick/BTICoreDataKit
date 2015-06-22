//
//  BTICoreDataKit -- [https://github.com/BriTerIdeas/BTICoreDataKit]
//  v1.2
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "NSPersistentStoreCoordinator+BTICoreDataKitAdditions.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// Private Constants

@implementation NSPersistentStoreCoordinator (BTICoreDataKitAdditions)

- (NSPersistentStore *)addPersistentStoreWithTypeBTI:(NSString *)storeType
                                       configuration:(NSString *)configuration
                                                 URL:(NSURL *)storeURL
                                             options:(NSDictionary *)options
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSError *error = nil;
    NSPersistentStore *store = [self addPersistentStoreWithType:storeType
                                                  configuration:configuration
                                                            URL:storeURL
                                                        options:options
                                                          error:&error];
    if (store == nil)
    {
        NSLog(@"BTI ERROR: Add persistent store: %@", [error localizedDescription]);
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return store;
}

- (BOOL)removePersistentStoreBTI:(NSPersistentStore *)store
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSError *error = nil;
    BOOL isRemoveSuccessful = [self removePersistentStore:store error:&error];
    if (!isRemoveSuccessful)
    {
        NSLog(@"BTI ERROR: Remove persistent store: %@", [error localizedDescription]);
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return isRemoveSuccessful;
}

@end
