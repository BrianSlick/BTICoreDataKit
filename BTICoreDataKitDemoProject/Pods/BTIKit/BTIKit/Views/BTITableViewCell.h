//
//  BTITableViewCell.h
//  BTIKit
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//
//  reuseIdentifier concept from http://iphonedevelopment.blogspot.com/2010/04/table-view-cells-redux.html

/*
 
 OVERVIEW
 
 This class overrides the reuseIdentifier to match the class name.  A class method is also provided to return that name.  This does work with XIB-based cells.  This avoids the issue of forgetting to specify the cell identifier in the XIB.  Naturally this will only work if all cells powered by this class should have the same reuse identifier.
 
 */

// Libraries
#import <UIKit/UIKit.h>

// Forward Declarations and Classes

// Public Constants

// Protocols

@interface BTITableViewCell : UITableViewCell

// Public Properties


// Public Methods

/**
 Returns the class name as a string
 
 @return The class name as a string
 */
+ (NSString *)reuseIdentifierBTI;

@end
