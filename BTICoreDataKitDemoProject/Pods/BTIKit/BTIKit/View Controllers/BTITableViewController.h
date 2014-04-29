//
//  BTITableViewController.h
//  BTIKit
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

/*
 
 OVERVIEW
 
 This is a view controller class intended to provide common elements needed to support a table view.  It does not, however, provide a primary data storage mechanism, leaving that for subclasses to define.  It can be viewed as an alternative to UITableViewController, though it does not deliberately attempt to replicate any functionality of that class.
 
 This class is intended to be used with a XIB file containing a UITableView, however if the IBOutlet has not been populated by the time viewWillAppear is called, a full-screen, plain table view will be created.
 
 This class implements the minimum setup necessary to support a UISearchDisplayController.  Subclasses must override the handleSearchForTerm: method in order to implement the actual search logic that this class does not provide.
 
 The selectionSet is provided to handle cases where multiple selections (ex: checkmarks) would be useful, and the selectedObject is for single selection.  This class does not implement any logic utilizing these properties, merely makes them available.
 
 To unify table view datasource/delegate methods, the itemInTableView:atIndexPath: method is provided.  This class does not implement any particular logic.  Subclasses should override this method to select an appropriate object depending on which table view is asking.
 
 */

// Libraries

// Forward Declarations and Classes
#import "BTIViewController.h"

// Public Constants

// Protocols

@interface BTITableViewController : BTIViewController <UITableViewDelegate, UITableViewDataSource, UISearchDisplayDelegate, UISearchBarDelegate>

#pragma mark - IBOutlet Properties

/// Returns the table view managed by this class. If it has not been supplied via IB or viewDidLoad, a plain table view will be created in viewWillAppear:
@property (nonatomic, strong) IBOutlet UITableView *tableView;

#pragma mark - Other Public Properties

/// A collection of "selected" objects. This is not automatically used anywhere, merely provided for convenience. Can be used with checkmarks. Items in the set are "selected", all others are not, etc.
@property (nonatomic, strong, readonly) NSMutableSet *selectionSet;

/// A single "selected" object. This is not automatically used anywhere, merely provided for convenience. Can be used with checkmarks. This item is "selected", all others are not, etc.
@property (nonatomic, strong) id selectedObject;

/// If the UISearchDisplayController, this will be populated with the search field text. Subclasses should use this combined with handleSearchForTerm: to filter contents.
@property (nonatomic, copy) NSString *savedSearchTerm;

#pragma mark - Public Methods

/**
 This method is automatically called by searchDisplayController:shouldReloadTableForSearchString:.  Subclasses should override this method to provide the actual search logic, and call super.
 
 @param searchTerm String value for which to search
 */
- (void)handleSearchForTerm:(NSString *)searchTerm NS_REQUIRES_SUPER;

/**
 This is a generic method to provide an object within table view datasource/delegate methods.  The standard implementation does nothing, as there is no data structure here.  Subclasses should override this method and return an appropriate object.  No need to call super.
 
 @param tableView The table view that is requesting data.
 @param indexPath The location in \em tableView to populate.
 */
- (id)itemInTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath;    

@end
