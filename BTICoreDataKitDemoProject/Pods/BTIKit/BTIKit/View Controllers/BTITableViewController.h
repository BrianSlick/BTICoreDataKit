//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 This is a view controller class intended to provide common elements needed to support a table view.  It does not, however, provide a primary data storage mechanism, leaving that for subclasses to define.  It can be viewed as an alternative to UITableViewController, though it does not deliberately attempt to replicate any functionality of that class.
 
 This class is intended to be used with a XIB file containing a UITableView, however if the IBOutlet has not been populated by the time viewWillAppear is called, a full-screen, plain table view will be created.
 
 This class implements the minimum setup necessary to support a UISearchController.  Subclasses must override the handleSearchForTerm: method in order to implement the actual search logic that this class does not provide.
 
 The selectionSet is provided to handle cases where multiple selections (ex: checkmarks) would be useful, and the selectedObject is for single selection.  This class does not implement any logic utilizing these properties, merely makes them available.
 
 To unify table view datasource/delegate methods, the itemInTableView:atIndexPath: method is provided.  This class does not implement any particular logic.  Subclasses should override this method to select an appropriate object depending on which table view is asking.
 
 */

// Libraries

// Forward Declarations and Classes
#import "BTIViewController.h"

// Public Constants

// Protocols

@interface BTITableViewController : BTIViewController <UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating>

#pragma mark - IBOutlet Properties

/// Returns the table view managed by this class. If it has not been supplied via IB or viewDidLoad, a plain table view will be created in viewDidLoad
@property (nullable, nonatomic, strong) IBOutlet UITableView *tableView;

#pragma mark - Other Public Properties

/// Default search controller
@property (nullable, nonatomic, strong, readonly) UISearchController *searchController;

/// A collection of "selected" objects. This is not automatically used anywhere, merely provided for convenience. Can be used with checkmarks. Items in the set are "selected", all others are not, etc.
@property (nonnull, nonatomic, strong, readonly) NSMutableSet *selectionSet;

/// A single "selected" object. This is not automatically used anywhere, merely provided for convenience. Can be used with checkmarks. This item is "selected", all others are not, etc.
@property (nullable, nonatomic, strong) id selectedObject;

/// If the UISearchDisplayController, this will be populated with the search field text. Subclasses should use this combined with handleSearchForTerm: to filter contents.
@property (nullable, nonatomic, copy) NSString *savedSearchTerm;

#pragma mark - Public Methods

/**
 This method is automatically called by searchDisplayController:shouldReloadTableForSearchString:.  Subclasses should override this method to provide the actual search logic, and call super.
 
 @param searchTerm String value for which to search
 */
- (void)handleSearchForTerm:(nullable NSString *)searchTerm NS_REQUIRES_SUPER;

/**
 This is a generic method to provide an object within table view datasource/delegate methods.  The standard implementation does nothing, as there is no data structure here.  Subclasses should override this method and return an appropriate object.  No need to call super.
 
 @param tableView The table view that is requesting data.
 @param indexPath The location in \em tableView to populate.
 */
- (nullable id)itemInTableView:(nullable UITableView *)tableView atIndexPath:(nullable NSIndexPath *)indexPath;


/**
 Designated method for defining the cells and header/footer views for a given table view. Default implementation does nothing. Subclasses should override, call to super is not necessary. This method will be automatically called from viewDidLoad for the primary table view. It will need to be called manually for any other table views, ex: search table view
 
 @param tableView The table view for which nibs should be registered.
 */
- (void)registerNibsForTableView:(nullable UITableView *)tableView;

/**
 This method will add (or remove) the search bar belonging to \em searchController to the table view's header view. The search bar is not shown by default.
 
 @param isVisible YES to show the search bar, NO to remove it.
 */
- (void)setSearchInterfaceVisible:(BOOL)isVisible;

@end
