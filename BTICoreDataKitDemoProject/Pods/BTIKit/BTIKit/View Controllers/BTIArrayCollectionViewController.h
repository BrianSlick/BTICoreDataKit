//
//  BTIArrayCollectionViewController.h
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in August 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
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
@property (nonatomic, strong, readonly) NSMutableArray *mainContents;

@end
