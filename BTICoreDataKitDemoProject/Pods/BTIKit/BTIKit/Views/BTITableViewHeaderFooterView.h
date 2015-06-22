//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 This class overrides the reuseIdentifier to match the class name.  A class method is also provided to return that name.  This does work with XIB-based cells.  This avoids the issue of forgetting to specify the cell identifier in the XIB.  Naturally this will only work if all cells powered by this class should have the same reuse identifier.
 
 */

// Libraries
@import UIKit;

// Forward Declarations and Classes

// Public Constants

// Protocols

@interface BTITableViewHeaderFooterView : UITableViewHeaderFooterView

// Public Properties


// Public Methods

/**
 Returns the class name as a string
 
 @return The class name as a string
 */
+ (NSString *)reuseIdentifierBTI;

/**
 Creates and registers a UINib object matching the class name with the provided table view
 
 @param tableView The UITableView object with which to register the Nib
 */
+ (void)registerNibForTableViewBTI:(UITableView *)tableView;

/**
 Dequeues a reusable view of receiver's class type from the provided table view, or nil if no nib is registered.
 
 @param tableView the UITableView object from which to dequeue a header footer view.
 */
+ (instancetype)dequeueHeaderFooterViewFromTableViewBTI:(UITableView *)tableView;

@end
