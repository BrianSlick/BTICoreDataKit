//
//  BTICoreDataStackManagerTests.m
//  BTICoreDataKitDemoProject
//
//  Created by Brian Slick on 4/24/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BTICoreDataKit.h"
#import "DemoPerson.h"

@interface BTICoreDataStackManagerTests : XCTestCase

@property (nonatomic, strong) BTICoreDataStackManager *coreDataStackManager;

@property (nonatomic, assign, getter = isContextSaved) BOOL contextSaved;

@end

@implementation BTICoreDataStackManagerTests

- (void)setUp
{
    [super setUp];

    [self setContextSaved:NO];

    BTICoreDataStackManager *coreDataManager = [[BTICoreDataStackManager alloc] initForUnitTesting];
    [self setCoreDataStackManager:coreDataManager];
    [coreDataManager resetDatabase];
}

- (void)tearDown
{
    [super tearDown];
    
    [self setCoreDataStackManager:nil];
}

- (void)testMainThreadContext
{
    BTICoreDataStackManager *coreDataManager = [self coreDataStackManager];
    
    NSManagedObjectContext *context = [coreDataManager mainThreadContext];
    
    XCTAssertNotNil(context, @"A MOC should exist");
    XCTAssertEqual(NSMainQueueConcurrencyType, [context concurrencyType], @"Wrong concurrency type");
}

- (void)testDatabaseFilePresentFails
{
    // Using in-memory store (for unit testing) means there is no database file to look for. So, just make sure it fails.
    
    BTICoreDataStackManager *coreDataManager = [self coreDataStackManager];

    XCTAssertFalse([coreDataManager isDatabaseFilePresent], @"There should not be a database file");
}

- (void)testManagedObjectModelName
{
    BTICoreDataStackManager *coreDataManager = [self coreDataStackManager];

    XCTAssertEqualObjects(@"DemoProject", [coreDataManager managedObjectModelName], @"Model name is wrong");
}

- (void)testDatabaseFileName
{
    BTICoreDataStackManager *coreDataManager = [self coreDataStackManager];
    
    XCTAssertEqualObjects(@"CoreData.sqlite", [coreDataManager databaseFileName], @"Database file name is wrong");
}

- (void)testPersistentStoreOptions
{
    BTICoreDataStackManager *coreDataManager = [self coreDataStackManager];

    NSDictionary *options = [coreDataManager persistentStoreOptions];
    
    NSNumber *migrate = [options valueForKey:NSMigratePersistentStoresAutomaticallyOption];
    XCTAssertNotNil(migrate, @"There should be a migration value");
    XCTAssertEqualObjects(@YES, migrate, @"Migration value should be YES");
    
    NSNumber *map = [options valueForKey:NSInferMappingModelAutomaticallyOption];
    XCTAssertNotNil(map, @"There should be a mapping value");
    XCTAssertEqualObjects(@YES, map, @"Mapping value should be YES");

    NSDictionary *walOptions = [options valueForKey:NSSQLitePragmasOption];
    XCTAssertNotNil(walOptions, @"There should be WAL options");

    NSString *walMode = [walOptions valueForKey:@"journal_mode"];
    XCTAssertNotNil(walMode, @"There should be a journal mode value");
    XCTAssertEqualObjects(@"DELETE", walMode, @"WAL should be disabled");
}

- (void)testSaveManagedObjectContext
{
    BTICoreDataStackManager *coreDataManager = [self coreDataStackManager];

    NSManagedObjectContext *context = [coreDataManager mainThreadContext];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(managedObjectContextDidSave:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:context];
    
    __unused DemoPerson *person = [DemoPerson newManagedObjectInContextBTI:context];
    
    [coreDataManager saveManagedObjectContext:context];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSManagedObjectContextDidSaveNotification
                                                  object:context];

}

- (void)testNewMainQueueManagedObjectContext
{
    BTICoreDataStackManager *coreDataManager = [self coreDataStackManager];

    NSManagedObjectContext *context = [coreDataManager mainThreadContext];

    NSManagedObjectContext *mainQueueContext = [coreDataManager newMainQueueManagedObjectContext];
    
    XCTAssertNotNil(mainQueueContext, @"Should have a context");
    XCTAssertEqual(NSMainQueueConcurrencyType, [mainQueueContext concurrencyType], @"Wrong concurrency type");
    XCTAssertEqualObjects([mainQueueContext parentContext], context, @"Should be a child of main context");
}

- (void)testNewPrivateQueueManagedObjectContext
{
    BTICoreDataStackManager *coreDataManager = [self coreDataStackManager];
    
    NSManagedObjectContext *context = [coreDataManager mainThreadContext];
    
    NSManagedObjectContext *privateQueueContext = [coreDataManager newPrivateQueueManagedObjectContext];
    
    XCTAssertNotNil(privateQueueContext, @"Should have a context");
    XCTAssertEqual(NSPrivateQueueConcurrencyType, [privateQueueContext concurrencyType], @"Wrong concurrency type");
    XCTAssertEqualObjects([privateQueueContext parentContext], context, @"Should be a child of main context");
}

#pragma mark - Notification Handlers

- (void)managedObjectContextDidSave:(NSNotification *)notification
{
    NSManagedObjectContext *context = [notification object];
    
    [self setContextSaved:(context == [[self coreDataStackManager] mainThreadContext])];
}

@end
