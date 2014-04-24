//
//  BTINSManagedObjectContextTests.m
//  BTICoreDataKitDemoProject
//
//  Created by Brian Slick on 4/23/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BTICoreDataKit.h"
#import "DemoPerson.h"

@interface BTINSManagedObjectContextTests : XCTestCase

@property (nonatomic, strong) BTICoreDataStackManager *coreDataStackManager;

@property (nonatomic, assign, getter = isContextSaved) BOOL contextSaved;

@end

@implementation BTINSManagedObjectContextTests

- (void)setUp
{
    [super setUp];
    
    BTICoreDataStackManager *coreDataManager = [[BTICoreDataStackManager alloc] initForUnitTesting];
    [coreDataManager loadPersistentStore];
    
    [self setCoreDataStackManager:coreDataManager];
    [self setContextSaved:NO];
    
    NSManagedObjectContext *context = [coreDataManager mainThreadContext];
    
    DemoPerson *person1 = [DemoPerson newManagedObjectInContextBTI:context];
    [person1 setFirstName:@"Person1"];
    
    DemoPerson *person2 = [DemoPerson newManagedObjectInContextBTI:context];
    [person2 setFirstName:@"Person2"];
}

- (void)tearDown
{
    [super tearDown];
    
    [self setCoreDataStackManager:nil];
}

- (void)testCountForFetchRequest
{
    NSManagedObjectContext *context = [[self coreDataStackManager] mainThreadContext];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    [fetchRequest setEntity:[DemoPerson entityDescriptionInContextBTI:context]];
    
    XCTAssertEqual([context countForFetchRequestBTI:fetchRequest], 2, @"Count is wrong");
}

- (void)testExecuteFetchRequest
{
    NSManagedObjectContext *context = [[self coreDataStackManager] mainThreadContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    [fetchRequest setEntity:[DemoPerson entityDescriptionInContextBTI:context]];

    NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES selector:@selector(localizedStandardCompare:)];
    [fetchRequest setSortDescriptors:@[ firstNameDescriptor ]];
    
    NSArray *people = [context executeFetchRequestBTI:fetchRequest];
    
    DemoPerson *person1 = [people objectAtIndex:0];
    DemoPerson *person2 = [people objectAtIndex:1];
    
    XCTAssertEqualObjects([person1 firstName], @"Person1", @"Name is wrong");
    XCTAssertEqualObjects([person2 firstName], @"Person2", @"Name is wrong");
}

- (void)testSave
{
    NSManagedObjectContext *context = [[self coreDataStackManager] mainThreadContext];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(managedObjectContextDidSave:)
                                                 name:NSManagedObjectContextDidSaveNotification
                                               object:context];
    
    [context saveBTI];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSManagedObjectContextDidSaveNotification
                                                  object:context];
    
    XCTAssertTrue([self isContextSaved], @"Context did not save");
}

#pragma mark - Notification Handlers

- (void)managedObjectContextDidSave:(NSNotification *)notification
{
    NSManagedObjectContext *context = [notification object];

    [self setContextSaved:(context == [[self coreDataStackManager] mainThreadContext])];
}

@end
