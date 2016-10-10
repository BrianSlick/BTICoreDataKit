//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 This is a specific implementation of BTICollectionViewController that provides data storage via BTITableContentsManager.  itemInCollectionView:atIndexPath: has been overridden accordingly.
 
 */

// Libraries

// Forward Declarations and Classes
#import "BTICollectionViewController.h"
#import "BTITableContentsManager.h"

// Public Constants

// Protocols

@interface BTIManagerCollectionViewController : BTICollectionViewController

#pragma mark - Public Properties

/// Contents manager for data to display in the primary collection view.
@property (nonnull, nonatomic, strong, readonly) BTITableContentsManager *mainContentsManager;

#pragma mark - Public Methods

/** Returns the content manager for a given collection view. This class only cares about the collectionView property. It will return nil for any other collection view.
 
 @param collectionView The collection view that is requesting data.
 
 @return Either \em mainContentsManager or nil, depending on which \em collectionView is provided.
 */
- (nullable BTITableContentsManager *)contentsManagerForCollectionView:(nullable UICollectionView *)collectionView;

/** Returns the BTITableSectionInfo object corresponding to the collectionView at the desired index.
 
 @param collectionView The collectionView that is requesting data.
 @param index Index for the section
 
 @return The BTITableSectionInfo object at \em index.
 */
- (nullable BTITableSectionInfo *)sectionInfoInCollectionView:(nullable UICollectionView *)collectionView atIndex:(NSUInteger)index;

/** Returns the BTITableRowInfo object corresponding to the collectionView at the desired index path.
 
 @param collectionView The collectionView that is requesting data.
 @param indexPath Index path for the row info
 
 @return The BTITableRowInfo object at \em indexPath
 */
- (nullable BTITableRowInfo *)rowInfoInCollectionView:(nullable UICollectionView *)collectionView atIndexPath:(nullable NSIndexPath *)indexPath;

/** Returns the BTITableRowInfo's represented object corresponding to the collectionView at the desired index path.
 
 @param collectionView The collectionView that is requesting data.
 @param indexPath Index path for the row info
 
 @return The BTITableRowInfo's represented object at \em indexPath
 */
- (nullable id)representedObjectInCollectionView:(nullable UICollectionView *)collectionView atIndexPath:(nullable NSIndexPath *)indexPath;

@end
