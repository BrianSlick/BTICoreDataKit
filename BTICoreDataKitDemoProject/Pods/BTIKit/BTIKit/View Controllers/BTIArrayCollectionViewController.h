//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 This is a specific implementation of BTICollectionViewController that provides a basic array data store. itemInCollectionView:atIndexPath: has been overridden accordingly.
 
 */

// Libraries

// Forward Declarations and Classes
#import "BTICollectionViewController.h"

// Public Constants

// Protocols

@interface BTIArrayCollectionViewController : BTICollectionViewController

#pragma mark - Public Properties

/// Container for data to display in the primary collection view.
@property (nonnull, nonatomic, strong, readonly) NSMutableArray *mainContents;

@end
