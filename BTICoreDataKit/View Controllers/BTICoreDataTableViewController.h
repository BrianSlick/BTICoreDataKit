//
//  BTICoreDataTableViewController.h
//  BTICoreDataKit
//
//  Created by Brian Slick in April 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTICoreDataKit
//

/*
 
 OVERVIEW
 
 This is a specific implementation of BTITableViewController that provides data storage via NSFetchedResultsController(s), one for the main contents and one for the search contents.  itemInTableView:atIndexPath: has been overridden accordingly.
 
 */


// Libraries
#import "BTICoreDataKit.h"
@import CoreData;

// Forward Declarations and Classes
#import "BTITableViewController.h"

// Public Constants

// Protocols

@interface BTICoreDataTableViewController : BTITableViewController

#pragma mark - Public Properties

/// MOC provided for convenience. It is not actively used by this class.
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

/// FRC to be used with the primary table view. Setting this value will automatically populate the FRC property of \em mainTableViewManager.
@property (nonatomic, strong) NSFetchedResultsController *mainFetchedResultsController;

/// Manager for the primary table view and main FRC.
@property (nonatomic, strong, readonly) BTIFetchedResultsControllerTableViewManager *mainTableViewManager;

/// FRC to be used with the search table view. Setting this value will automatically populate the FRC property of \em searchTableViewManager.
@property (nonatomic, strong) NSFetchedResultsController *searchFetchedResultsController;

/// Manager for the search table view and search FRC.
@property (nonatomic, strong, readonly) BTIFetchedResultsControllerTableViewManager *searchTableViewManager;

#pragma mark - Public Methods

/**
 This method is used to define the FRC for the main table view.  The default implementation does nothing.  Subclasses should override this method, create a FRC, and supply it to the \em mainFetchedResultsController property.  There is no need to call super.
 
 This method will be called automatically if the \em mainFetchedResultsController property is empty.
 */
- (void)loadMainFetchedResultsController;

/**
 This method is used to define the FRC for the search table view.  The default implementation does nothing.  Subclasses should override this method, create a FRC, and supply it to the \em searchFetchedResultsController property.  There is no need to call super.
 
 This method will be called automatically if the \em searchFetchedResultsController property is empty.
 */
- (void)loadSearchFetchedResultsController;

/**
 Returns the FRC that is driving the specified table view. Default implementation only works with the \em tableView property from BTITableViewController, and the search results table view. This method can be overridden in subclasses to work with different/additional table views.
 
 @param tableView The calling table view.
 
 @return Either \em mainFetchedResultsController or \em searchFetchedResultsController, or nil.
 */
- (NSFetchedResultsController *)fetchedResultsControllerForTableView:(UITableView *)tableView;

@end
