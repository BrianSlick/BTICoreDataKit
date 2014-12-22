//
//  BTICollectionViewController.h
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in August 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

/*
 
 OVERVIEW
 
 This is a view controller class intended to provide common elements needed to support a collection view.  It does not, however, provide a primary data storage mechanism, leaving that for subclasses to define.
 
 This class is intended to be used with a XIB file containing a UICollectionView.
 
 The selectionSet is provided to handle cases where multiple selections (ex: checkmarks) would be useful, and the selectedObject is for single selection.  This class does not implement any logic utilizing these properties, merely makes them available.
 
 To unify collection view datasource/delegate methods, the itemInCollectionView:atIndexPath: method is provided.  This class does not implement any particular logic.  Subclasses should override this method to select an appropriate object depending on which collection view is asking.
 
 */

// Libraries

// Forward Declarations and Classes
#import "BTIViewController.h"

// Public Constants

// Protocols

@interface BTICollectionViewController : BTIViewController <UICollectionViewDelegate, UICollectionViewDataSource>

#pragma mark - IBOutlet Properties

/// Returns the collection view managed by this class. If it has not been supplied via IB or viewDidLoad, a collection view will be created in viewWillAppear:
@property (nonatomic, strong) IBOutlet UICollectionView *collectionView;

#pragma mark - Other Public Properties

/// A collection of "selected" objects. This is not automatically used anywhere, merely provided for convenience. Can be used with checkmarks. Items in the set are "selected", all others are not, etc.
@property (nonatomic, strong, readonly) NSMutableSet *selectionSet;

/// A single "selected" object. This is not automatically used anywhere, merely provided for convenience. Can be used with checkmarks. This item is "selected", all others are not, etc.
@property (nonatomic, strong) id selectedObject;

#pragma mark - Public Methods

/**
 This is a generic method to provide an object within collection view datasource/delegate methods.  The standard implementation does nothing, as there is no data structure here.  Subclasses should override this method and return an appropriate object.  No need to call super.
 
 @param collectionView The collection view that is requesting data.
 @param indexPath The location in \em collectionView to populate.
 */
- (id)itemInCollectionView:(UICollectionView *)collectionView atIndexPath:(NSIndexPath *)indexPath;

/**
 Designated method for defining the cells and supplementary views for a given collection view. Default implementation does nothing. Subclasses should override, call to super is not necessary. This method will be automatically called from viewDidLoad for the primary collection view. It will need to be called manually for any other collection views.
 
 @param collectionView The collection view for which nibs should be registered.
 */
- (void)registerNibsForCollectionView:(UICollectionView *)collectionView;

@end
