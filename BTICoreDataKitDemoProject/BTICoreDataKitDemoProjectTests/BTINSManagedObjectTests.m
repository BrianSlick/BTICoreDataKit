//
//  BTINSManagedObjectTests.m
//  BTICoreDataKitDemoProject
//
//  Created by Brian Slick on 4/23/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BTICoreDataKit.h"
#import "DemoPerson.h"

@interface BTINSManagedObjectTests : XCTestCase

@property (nonatomic, strong) BTICoreDataStackManager *coreDataStackManager;

@end

@implementation BTINSManagedObjectTests

- (void)setUp
{
    [super setUp];

    [self setCoreDataStackManager:[[BTICoreDataStackManager alloc] initForUnitTesting]];
}

- (void)tearDown
{
    [super tearDown];
    
    [self setCoreDataStackManager:nil];
}

- (void)testEntityDescription
{
    NSManagedObjectContext *context = [[self coreDataStackManager] mainThreadContext];
    
    NSEntityDescription *personEntity = [DemoPerson entityDescriptionInContextBTI:context];
    
    XCTAssertEqualObjects([personEntity name], NSStringFromClass([DemoPerson class]), @"Entity name does not match");
}

- (void)testNewManagedObject
{
    NSManagedObjectContext *context = [[self coreDataStackManager] mainThreadContext];

    DemoPerson *person = [DemoPerson newManagedObjectInContextBTI:context];
    
    XCTAssertTrue([person isKindOfClass:[DemoPerson class]], @"Object class is wrong");
}

@end
