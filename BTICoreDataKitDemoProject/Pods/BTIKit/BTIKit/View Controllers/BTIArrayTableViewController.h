//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 This is a specific implementation of BTITableViewController that provides a basic array data store, one for the main contents and one for the search contents.  itemInTableView:atIndexPath: has been overridden accordingly.
 
 */

// Libraries

// Forward Declarations and Classes
#import "BTITableViewController.h"

// Public Constants

// Protocols

@interface BTIArrayTableViewController : BTITableViewController

#pragma mark - Public Properties

/// Container for data to display in the primary table view.
@property (nonatomic, strong, readonly) NSMutableArray *mainContents;

/// Container for data to display in the search table view.
@property (nonatomic, strong, readonly) NSMutableArray *searchContents;

#pragma mark - Public Methods

@end
