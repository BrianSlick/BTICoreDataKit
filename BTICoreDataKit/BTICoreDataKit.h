//
//  BTICoreDataKit.h
//  BTICoreDataKit
//  v1.1
//
//  Created by Brian Slick in April 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTICoreDataKit
//

#pragma mark - Dependencies

// BTICoreDataKit depends upon BTIKit
// https://github.com/BriTerIdeas/BTIKit
#import "BTIKit.h"

// System Libraries
@import CoreData;

#pragma mark - Models

#import "BTICoreDataStackManager.h"
#import "BTIFetchedResultsControllerTableViewManager.h"
#import "BTIFetchedResultsControllerCollectionViewManager.h"

#pragma mark - Categories

#import "BTITableSectionInfo+BTICoreDataKitAdditions.h"
#import "NSFetchedResultsController+BTICoreDataKitAdditions.h"
#import "NSManagedObject+BTICoreDataKitAdditions.h"
#import "NSManagedObjectContext+BTICoreDataKitAdditions.h"
#import "NSPersistentStoreCoordinator+BTICoreDataKitAdditions.h"

#pragma mark - View Controllers

#import "BTICoreDataTableViewController.h"


