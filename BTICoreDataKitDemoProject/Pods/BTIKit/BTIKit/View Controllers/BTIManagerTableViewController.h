//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 This is a specific implementation of BTITableViewController that provides data storage via BTITableContentsManager(s), one for the main contents and one for the search contents.  itemInTableView:atIndexPath: has been overridden accordingly.
 
 */

// Libraries

// Forward Declarations and Classes
#import "BTITableViewController.h"
#import "BTITableContentsManager.h"

// Public Constants

// Protocols

@interface BTIManagerTableViewController : BTITableViewController

#pragma mark - Public Properties

/// Contents manager for data to display in the primary table view.
@property (nonnull, nonatomic, strong, readonly) BTITableContentsManager *mainContentsManager;

/// Contents manager for data to display in the primary table view.
@property (nonnull, nonatomic, strong, readonly) BTITableContentsManager *searchContentsManager;

#pragma mark - Public Methods

/** Returns the content manager for a given table view. This class only cares about the tableView property and the search display controller's tableView. It will return nil for any other table view.
 
 @param tableView The table that is requesting data.
 
 @return Either \em mainContentsManager or \em searchContentsManager, depending on which \em tableView is provided.
 */
- (nullable BTITableContentsManager *)contentsManagerForTableView:(nullable UITableView *)tableView;

/** Returns the BTITableSectionInfo object corresponding to the tableView at the desired index.
 
 @param tableView The table that is requesting data.
 @param index Index for the section
 
 @return The BTITableSectionInfo object at \em index.
 */
- (nullable BTITableSectionInfo *)sectionInfoInTableView:(nullable UITableView *)tableView atIndex:(NSUInteger)index;

/** Returns the BTITableRowInfo object corresponding to the tableView at the desired index path.
 
 @param tableView The table that is requesting data.
 @param indexPath Index path for the row info
 
 @return The BTITableRowInfo object at \em indexPath
 */
- (nullable BTITableRowInfo *)rowInfoInTableView:(nullable UITableView *)tableView atIndexPath:(nullable NSIndexPath *)indexPath;

/** Returns the BTITableRowInfo's represented object corresponding to the tableView at the desired index path.
 
 @param tableView The table that is requesting data.
 @param indexPath Index path for the row info
 
 @return The BTITableRowInfo's represented object at \em indexPath
 */
- (nullable id)representedObjectInTableView:(nullable UITableView *)tableView atIndexPath:(nullable NSIndexPath *)indexPath;

@end
