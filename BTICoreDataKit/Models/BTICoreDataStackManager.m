//
//  BTICoreDataStackManager.m
//  BTICoreDataKit
//
//  Created by Brian Slick in April 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTICoreDataKit
//

#import "BTICoreDataStackManager.h"

// Models and other global
#import "BTICoreDataKit.h"

// Private Constants
NSString *const kBTIManagedObjectModelFileExtension = @"momd";
NSString *const kBTIDatabaseFileExtension = @"sqlite";

@interface BTICoreDataStackManager ()

// Private Properties
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, strong) NSPersistentStore *persistentStore;

@property (nonatomic, strong) NSManagedObjectContext *mainThreadContext;

@property (nonatomic, assign, getter = isUnitTesting) BOOL unitTesting;

@end

@implementation BTICoreDataStackManager

#pragma mark - Synthesized Properties

#pragma mark - Dealloc and Memory Management

- (void)dealloc
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Initialization

- (id)init
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(applicationDidEnterBackground:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    }
    
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return self;
}

- (instancetype)initForUnitTesting
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    self = [super init];
    if (self)
    {
        [self setUnitTesting:YES];
    }

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return self;
}

#pragma mark - Custom Getters and Setters

- (NSManagedObjectModel *)managedObjectModel
{
    if (_managedObjectModel == nil)
    {
        NSURL *url = [self managedObjectModelURL];
        
        if (url != nil)
        {
            _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:url];
        }
    }
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (_persistentStoreCoordinator == nil)
    {
        NSManagedObjectModel *model = [self managedObjectModel];
        
        if (model != nil)
        {
            _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        }
    }
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext *)mainThreadContext
{
    if (_mainThreadContext == nil)
    {
        NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
        if (coordinator != nil)
        {
            _mainThreadContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
            [_mainThreadContext setPersistentStoreCoordinator:coordinator];
        }
    }
    return _mainThreadContext;
}

#pragma mark - Notification Handlers

- (void)managedObjectContextDidSave:(NSNotification *)notification
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSManagedObjectContext *context = [notification object];
    NSManagedObjectContext *parentContext = [context parentContext];
    
    if (parentContext == nil)
    {
		//BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - MOC does not have a parent", self, __PRETTY_FUNCTION__);
        return;
    }
    
    __weak NSManagedObjectContext *weakContext = parentContext;
    
    [weakContext performBlock:^{
        
        [weakContext mergeChangesFromContextDidSaveNotification:notification];
        [weakContext saveBTI];
        
    }];
    
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)applicationDidEnterBackground:(NSNotification *)notification
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [[self mainThreadContext] saveBTI];
    
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - File and Utilty Methods

- (BOOL)isDatabaseFilePresent
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSURL *url = [self persistentStoreURL];
    
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [[NSFileManager defaultManager] fileExistsAtPath:[url path]];
}

- (NSString *)managedObjectModelName
{
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSArray *urls = [bundle URLsForResourcesWithExtension:kBTIManagedObjectModelFileExtension subdirectory:nil];
    
    if ([urls count] == 0)
    {
        return nil;
    }
    
    NSURL *url = [urls lastObject];
    
    NSString *fileName = [url lastPathComponent];
    NSString *nameToReturn = [fileName stringByDeletingPathExtension];
    
    return nameToReturn;
}

- (NSURL *)managedObjectModelURL
{
    NSString *modelName = [self managedObjectModelName];
    
    if (modelName == nil)
    {
        return nil;
    }
    
    if (![[modelName pathExtension] isEqualToString:kBTIManagedObjectModelFileExtension])
    {
        modelName = [modelName stringByAppendingPathExtension:kBTIManagedObjectModelFileExtension];
    }
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *url = [bundle URLForResource:modelName withExtension:nil];
    
    return url;
}

- (NSString *)databaseFileName
{
    return @"CoreData.sqlite";
}

- (NSURL *)persistentStoreURL
{
    NSString *fileName = [self databaseFileName];
    
    NSAssert(fileName != nil, @"databaseFileName must not be nil");
    
    if (![[fileName pathExtension] isEqualToString:kBTIDatabaseFileExtension])
    {
        fileName = [fileName stringByDeletingPathExtension];
        fileName = [fileName stringByAppendingPathExtension:kBTIDatabaseFileExtension];
    }
    
    NSURL *url = [[NSFileManager defaultManager] URLForDirectoryBTI:NSApplicationSupportDirectory
                                                           inDomain:NSUserDomainMask
                                                  appropriateForURL:nil
                                                             create:YES];
    
    url = [url URLByAppendingPathComponent:fileName];
    
    return url;
}

- (NSDictionary *)persistentStoreOptions
{
	BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
	NSMutableDictionary *options = [NSMutableDictionary dictionary];
	[options setObject:@YES forKey:NSMigratePersistentStoresAutomaticallyOption];
	[options setObject:@YES forKey:NSInferMappingModelAutomaticallyOption];
    
    // https://developer.apple.com/library/ios/releasenotes/DataManagement/WhatsNew_CoreData_iOS/
    NSMutableDictionary *pragmaOptions = [NSMutableDictionary dictionary];
    [pragmaOptions setObject:@"DELETE" forKey:@"journal_mode"];
    
    [options setObject:[NSDictionary dictionaryWithDictionary:pragmaOptions] forKey:NSSQLitePragmasOption];
    
	BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return [NSDictionary dictionaryWithDictionary:options];
}

#pragma mark - Persistent Store Methods

- (void)loadPersistentStore
{
	BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSPersistentStore *store = [self persistentStore];
    
    if (store != nil)
    {
		BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Store already loaded", self, __PRETTY_FUNCTION__);
        return;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator == nil)
    {
		BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - PSC does not exist", self, __PRETTY_FUNCTION__);
        return;
    }
    
    if ([self isUnitTesting])
    {
        store = [coordinator addPersistentStoreWithTypeBTI:NSInMemoryStoreType
                                             configuration:nil
                                                       URL:nil
                                                   options:nil];
    }
    else
    {
        NSURL *url = [self persistentStoreURL];
        
        store = [coordinator addPersistentStoreWithTypeBTI:NSSQLiteStoreType
                                             configuration:nil
                                                       URL:url
                                                   options:[self persistentStoreOptions]];
    }
    [self setPersistentStore:store];
    
	BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)unloadPersistentStore
{
	BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSPersistentStore *store = [self persistentStore];
    
    if (store == nil)
    {
		BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Fallback store doesn't exist", self, __PRETTY_FUNCTION__);
        return;
    }
    
    [[self mainThreadContext] reset];
    
    if ([store persistentStoreCoordinator] == nil)
    {
        [self setPersistentStore:nil];
        
		BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Store does not belong to PSC", self, __PRETTY_FUNCTION__);
        return;
    }
    
    [[self persistentStoreCoordinator] removePersistentStoreBTI:store];
    
    [self setPersistentStore:nil];
    
	BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Major Database Operations

- (NSURL *)generateBackupFile
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    NSPersistentStore *store = [self persistentStore];
    
    NSString *fileName = [@"export" stringByAppendingPathExtension:kBTIDatabaseFileExtension];
    NSString *exportStorePath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
	NSURL *exportStoreURL = [NSURL fileURLWithPath:exportStorePath];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:exportStorePath])
    {
        [fileManager removeItemAtPathBTI:exportStorePath];
    }
    
    NSError *error = nil;
    NSPersistentStore *exportStore = [coordinator migratePersistentStore:store
                                                                   toURL:exportStoreURL
                                                                 options:[self persistentStoreOptions]
                                                                withType:NSSQLiteStoreType
                                                                   error:&error];
    
    if (exportStore == nil)
    {
        NSLog(@"Error with store migration\n%@", [error localizedDescription]);
        
		//BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Error creating export store", self, __PRETTY_FUNCTION__);
        return nil;
    }
    
    for (NSPersistentStore *aStore in [coordinator persistentStores])
    {
        [coordinator removePersistentStoreBTI:aStore];
    }
    
    // The migration process causes the input store to be unloaded.  Clean up and reload it
    [self unloadPersistentStore];
    [self loadPersistentStore];
    
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return exportStoreURL;
}

- (void)resetDatabase
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [self unloadPersistentStore];
    
    [self deleteDatabaseFiles];
    
    [self loadPersistentStore];
    
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)replaceDatabaseWithSQLiteData:(NSData *)data
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSString *fileName = [@"import" stringByAppendingPathExtension:kBTIDatabaseFileExtension];
    NSString *importFilePath = [NSTemporaryDirectory() stringByAppendingPathComponent:fileName];
	NSURL *importFileURL = [NSURL fileURLWithPath:importFilePath];
    
    [data writeToURL:importFileURL atomically:YES];
    
    [self replaceDatabaseWithSQLiteFile:importFileURL];
    
    [[NSFileManager defaultManager] removeItemAtPathBTI:importFilePath];
    
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)replaceDatabaseWithSQLiteFile:(NSURL *)url
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (url == nil)
    {
		//BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - No input URL", self, __PRETTY_FUNCTION__);
        return;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:[url path]])
    {
		//BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - No file found at URL", self, __PRETTY_FUNCTION__);
        return;
    }
    
    NSURL *destinationURL = [self persistentStoreURL];
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    
    if (coordinator == nil)
    {
		//BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Coordinator does not exist", self, __PRETTY_FUNCTION__);
        return;
    }
    
    NSPersistentStore *importStore = [coordinator addPersistentStoreWithTypeBTI:NSSQLiteStoreType
                                                                  configuration:nil
                                                                            URL:url
                                                                        options:[self persistentStoreOptions]];
    
    if (importStore == nil)
    {
		//BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - <reason not specified>", self, __PRETTY_FUNCTION__);
        return;
    }
    
    [self unloadPersistentStore];
    
    NSError *error = nil;
    NSPersistentStore *migratedStore = [coordinator migratePersistentStore:importStore
                                                                     toURL:destinationURL
                                                                   options:[self persistentStoreOptions]
                                                                  withType:NSSQLiteStoreType
                                                                     error:&error];
    
    if (migratedStore == nil)
    {
        NSLog(@"Error with store migration\n%@", [error localizedDescription]);
        
		//BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Store Migration Error", self, __PRETTY_FUNCTION__);
        return;
    }
    
    for (NSPersistentStore *store in [coordinator persistentStores])
    {
        [coordinator removePersistentStoreBTI:store];
    }
    
    [self loadPersistentStore];
    
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)deleteDatabaseFiles
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSURL *fallbackURL = [self persistentStoreURL];
    
    NSURL *rootURL = [fallbackURL URLByDeletingPathExtension];
    
    NSArray *extensions = @[ @"sqlite", @"sqlite-shm", @"sqlite-wal", @"sqlite-journal" ];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    for (NSString *extension in extensions)
    {
        NSURL *fileURL = [rootURL URLByAppendingPathExtension:extension];
        NSString *path = [fileURL path];
        
        if ([fileManager fileExistsAtPath:path])
        {
            [fileManager removeItemAtPathBTI:path];
        }
    }
    
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - MOC Methods

- (void)saveManagedObjectContext:(NSManagedObjectContext *)context
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (context == [self mainThreadContext])
    {
        [context saveBTI];
        
		//BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Saving mainThreadContext", self, __PRETTY_FUNCTION__);
        return;
    }
    
    if ([context parentContext] != [self mainThreadContext])
    {
        [context saveBTI];
        
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - MOC does not belong to this family", self, __PRETTY_FUNCTION__);
        return;
    }
    
    BTINotificationInfo *notificationInfo = [BTINotificationInfo infoWithObserver:self
                                                                         selector:@selector(managedObjectContextDidSave:)
                                                                             name:NSManagedObjectContextDidSaveNotification
                                                                           object:context
                                                                         lifespan:BTINotificationInfoLifespanCustom];
    
    [notificationInfo startListening];
    
	[context saveBTI];
    
    [notificationInfo stopListening];
    
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (NSManagedObjectContext *)newMainQueueManagedObjectContext
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSManagedObjectContext *parentContext = [self mainThreadContext];
    
    if (parentContext == nil)
    {
		//BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Parent Context Not Available", self, __PRETTY_FUNCTION__);
        return nil;
    }
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    [context setParentContext:parentContext];
    
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return context;
}

- (NSManagedObjectContext *)newPrivateQueueManagedObjectContext
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSManagedObjectContext *parentContext = [self mainThreadContext];
    
    if (parentContext == nil)
    {
		//BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Parent Context Not Available", self, __PRETTY_FUNCTION__);
        return nil;
    }
    
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    [context setParentContext:parentContext];
    
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return context;
}

#pragma mark - Singleton Access
// http://cocoasamurai.blogspot.com/2011/04/singletons-your-doing-them-wrong.html

+ (instancetype)sharedCoreDataStackManager
{
	static dispatch_once_t pred;
	static BTICoreDataStackManager *shared = nil;
    
	dispatch_once(&pred, ^{
        
		shared = [[[self class] alloc] init];
        
	});
    
	return shared;
}

@end
