//
//  BTICoreDataKit -- [https://github.com/BriTerIdeas/BTICoreDataKit]
//  v1.2
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//


/*
 
 OVERVIEW

 The purpose of this class is to easily add a Core Data stack and common behaviors to any app.  It can be used as-is, or subclassed to override any of noted methods below.  iCloud Core Data usage with this class is not supported and has not been tested.  Additional methods for importing/exporting/deleting the database file have been provided.
 
 IMPORTANT: You must manually call loadPersistentStore in order to have a persistent store available. This decision was made so that it does not block launching of the app. It can be called multiple times however, as subsequent calls are ignored.

 
 Managed Object Model - The default implementation scans the bundle looking for a .momd file. Subclass to provide a specific name.
 
 Store file - The default implementation places file a named "CoreData.sqlite" in the NSApplicationSupportDirectory. Subclass to provide a specific file name. The location cannot be customized.
 
 */

// Libraries
@import UIKit;
@import CoreData;

// Forward Declarations and Classes

// Public Constants

// Protocols

@interface BTICoreDataStackManager : NSObject

#pragma mark - Public Properties

/// Primary MOC for the Core Data stack.
@property (nonatomic, strong, readonly) NSManagedObjectContext *mainThreadContext;

#pragma mark - Singleton Access

+ (instancetype)sharedCoreDataStackManager;

#pragma mark - Misc Public Methods

/** Initializes the stack using an in-memory store type.
 */
- (instancetype)initForUnitTesting;

/** Indicates whether or not the database file exists
 
 @return Boolean value such that YES means the file exists, NO means it does not.
 */
- (BOOL)isDatabaseFilePresent;

#pragma mark - Subclass Customizable Values

/** Returns the name of the managed object model
 The default implementation of this method will scan the bundle looking for momd files. This method can be overridden in a subclass to force a particular name. The overridden value does not need to include the .momd file extension, but it can.
 
 @return The managed object model name
 */
- (NSString *)managedObjectModelName;

/** Returns the name of the sqlite file.
 
 The default value is "CoreData.sqlite".
 This method can be overridden in subclasses to force a particular file name.
 The file extension will become "sqlite" regardless of what is defined in the subclass.
 
 @return String object of the file name
 */
- (NSString *)databaseFileName;

/** Returns the options used to configure the persistent store
 The default implementation includes 'YES' for NSMigratePersistentStoresAutomaticallyOption and NSInferMappingModelAutomaticallyOption, and turns off SQL WAL.
 
 This method can be overridden in subclasses to define different options.
 
 @return Dictionary object of the persistent store options
 */
- (NSDictionary *)persistentStoreOptions;

#pragma mark - Major Database Operations

/** Loads the default persistent store.
 This method should be called before attempting to fetch objects. Nothing happens if the store is already loaded, so this method can be called multiple times.
 */
- (void)loadPersistentStore;

/** Creates a copy of the sqlite file
 
 @return URL to the location of the backup file
 */
- (NSURL *)generateBackupFile;

/** Deletes the existing database file and creates a new one
 */
- (void)resetDatabase;

/** Deletes the existing database and replaces it with the contents of data
 
 @param data NSData object from a SQLite file
 */
- (void)replaceDatabaseWithSQLiteData:(NSData *)data;

/** Deletes the existing database and replaces it with the contents of the file at the URL
 
 @param url NSURL object to a SQLite file
 */
- (void)replaceDatabaseWithSQLiteFile:(NSURL *)url;

#pragma mark - Child MOCs

/** Saves the managed object context
 
 @param NSManagedObjectContext object to be saved
 */
- (void)saveManagedObjectContext:(NSManagedObjectContext *)context;

/** Creates a new managed object context
 The MOC is configured using the NSMainQueueConcurrencyType option. It is a child of the mainThreadContext.
 
 @return A new NSManagedObjectContext object if successful, otherwise nil
 */
- (NSManagedObjectContext *)newMainQueueManagedObjectContext;

/** Creates a new managed object context
 The MOC is configured using the NSPrivateQueueConcurrencyType option. It is a child of the mainThreadContext.
 
 @return A new NSManagedObjectContext object if successful, otherwise nil
 */
- (NSManagedObjectContext *)newPrivateQueueManagedObjectContext;

@end
