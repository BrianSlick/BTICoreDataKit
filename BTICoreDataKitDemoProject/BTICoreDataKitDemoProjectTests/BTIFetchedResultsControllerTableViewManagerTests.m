//
//  BTIFetchedResultsControllerTableViewManagerTests.m
//  BTICoreDataKitDemoProject
//
//  Created by Brian Slick on 4/23/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BTICoreDataKit.h"
#import "DemoPerson.h"

@interface BTIFetchedResultsControllerTableViewManagerTests : XCTestCase <UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) BTICoreDataStackManager *coreDataStackManager;

@property (nonatomic, strong) BTIFetchedResultsControllerTableViewManager *tableViewManager;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign, getter = didTriggerWillChangeMethod) BOOL triggerWillChangeMethod;
@property (nonatomic, assign, getter = didTriggerDidChangeObjectMethod) BOOL triggerDidChangeObjectMethod;
@property (nonatomic, assign, getter = didTriggerDidChangeMethod) BOOL triggerDidChangeMethod;

@end

@implementation BTIFetchedResultsControllerTableViewManagerTests

- (void)setUp
{
    [super setUp];
    
    [self setTriggerWillChangeMethod:NO];
    [self setTriggerDidChangeObjectMethod:NO];
    [self setTriggerDidChangeMethod:NO];
    
    // Stack Manager
    
    BTICoreDataStackManager *coreDataManager = [[BTICoreDataStackManager alloc] initForUnitTesting];
    [coreDataManager loadPersistentStore];
    
    [self setCoreDataStackManager:coreDataManager];
    
    // Table view
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 480.0) style:UITableViewStylePlain];
    [self setTableView:tableView];
    
    [tableView setDataSource:self];
    [tableView setDelegate:self];
    
    // FRC
    
    NSManagedObjectContext *context = [coreDataManager mainThreadContext];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    [fetchRequest setEntity:[DemoPerson entityDescriptionInContextBTI:context]];
    
    NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES selector:@selector(localizedStandardCompare:)];
    [fetchRequest setSortDescriptors:@[ firstNameDescriptor ]];

    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                 managedObjectContext:context
                                                                                   sectionNameKeyPath:nil
                                                                                            cacheName:nil];
    [self setFetchedResultsController:controller];
    [controller performFetchBTI];
    
    // Table view Manager
    
    BTIFetchedResultsControllerTableViewManager *tableViewManager = [[BTIFetchedResultsControllerTableViewManager alloc] init];
    [self setTableViewManager:tableViewManager];
    
    [tableViewManager setTableView:tableView];
    [tableViewManager setFetchedResultsController:controller];
    
    // Data
    
    DemoPerson *person1 = [DemoPerson newManagedObjectInContextBTI:context];
    [person1 setFirstName:@"Person1"];
    
    DemoPerson *person2 = [DemoPerson newManagedObjectInContextBTI:context];
    [person2 setFirstName:@"Person2"];
    
    [context saveBTI];
}

- (void)tearDown
{
    [super tearDown];
    
    [self setCoreDataStackManager:nil];
}

- (void)testInsertObject
{
    NSManagedObjectContext *context = [[self coreDataStackManager] mainThreadContext];

    UITableView *tableView = [self tableView];
    
    [tableView reloadData];
    
    XCTAssertEqual([tableView numberOfRowsInSection:0], 2, @"Wrong number of rows");

    __unused DemoPerson *person = [DemoPerson newManagedObjectInContextBTI:context];
    
    [context saveBTI];

    XCTAssertEqual([tableView numberOfRowsInSection:0], 3, @"Wrong number of rows");
}

- (void)testDeleteObject
{
    NSManagedObjectContext *context = [[self coreDataStackManager] mainThreadContext];
    
    UITableView *tableView = [self tableView];
    
    [tableView reloadData];
    
    XCTAssertEqual([tableView numberOfRowsInSection:0], 2, @"Wrong number of rows");

    DemoPerson *person = [[self fetchedResultsController] objectAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    [context deleteObject:person];
    
    [context saveBTI];
    
    XCTAssertEqual([tableView numberOfRowsInSection:0], 1, @"Wrong number of rows");
}

- (void)testDelegateAssignment
{
    BTIFetchedResultsControllerTableViewManager *tableViewManager = [self tableViewManager];
    NSFetchedResultsController *controller = [self fetchedResultsController];
    
    XCTAssertEqualObjects(tableViewManager, [controller delegate], @"FRC delegate should have been assigned to manager.");
}

- (void)testAuxiliaryDelegatePassThrough
{
    NSManagedObjectContext *context = [[self coreDataStackManager] mainThreadContext];

    [[self tableViewManager] setAuxiliaryFetchedResultsControllerDelegate:self];
    
    __unused DemoPerson *person = [DemoPerson newManagedObjectInContextBTI:context];
    
    [context saveBTI];
    
    XCTAssertTrue([self didTriggerWillChangeMethod], @"Did not trigger delegate method");
    XCTAssertTrue([self didTriggerDidChangeObjectMethod], @"Did not trigger delegate method");
    XCTAssertTrue([self didTriggerDidChangeMethod], @"Did not trigger delegate method");
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    id<NSFetchedResultsSectionInfo> sectionInfo = [[[self fetchedResultsController] sections] objectAtIndex:section];
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Test"];
}

#pragma mark - NSFetchedResultsControllerDelegate methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self setTriggerWillChangeMethod:YES];
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    [self setTriggerDidChangeObjectMethod:YES];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self setTriggerDidChangeMethod:YES];
}

@end
