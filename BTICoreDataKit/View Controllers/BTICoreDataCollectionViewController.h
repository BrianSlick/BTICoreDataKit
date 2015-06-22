//
//  BTICoreDataKit -- [https://github.com/BriTerIdeas/BTICoreDataKit]
//  v1.2
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 This is a specific implementation of BTICollectionViewController that provides data storage via NSFetchedResultsController(s).  itemInCollectionView:atIndexPath: has been overridden accordingly.
 
 */


// Libraries
@import CoreData;

// Forward Declarations and Classes
#import "BTICollectionViewController.h"
#import "BTIFetchedResultsControllerCollectionViewManager.h"

// Public Constants

// Protocols

@interface BTICoreDataCollectionViewController : BTICollectionViewController

#pragma mark - Public Properties

/// MOC provided for convenience. It is not actively used by this class.
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

/// FRC to be used with the primary collection view. Setting this value will automatically populate the FRC property of \em mainCollectionViewManager.
@property (nonatomic, strong) NSFetchedResultsController *mainFetchedResultsController;

/// Manager for the primary collection view and main FRC.
@property (nonatomic, strong, readonly) BTIFetchedResultsControllerCollectionViewManager *mainCollectionViewManager;

#pragma mark - Public Methods

/**
 This method is used to define the FRC for the main collection view.  The default implementation does nothing.  Subclasses should override this method, create a FRC, and supply it to the \em mainFetchedResultsController property.  There is no need to call super.
 
 This method will be called automatically if the \em mainFetchedResultsController property is empty.
 */
- (void)loadMainFetchedResultsController;

/**
 Returns the FRC that is driving the specified collection view. Default implementation only works with the \em collectionView property from BTICollectionViewController. This method can be overridden in subclasses to work with different/additional collection views.
 
 @param collectionView The calling collection view.
 
 @return Either \em mainFetchedResultsController or nil.
 */
- (NSFetchedResultsController *)fetchedResultsControllerForCollectionView:(UICollectionView *)collectionView;

/**
 Returns a boolean indicating whether or not \em mainFetchedResultsController has been loaded. Will not cause \em mainFetchedResultsController to load.
 
 @return Boolean
 */
- (BOOL)isMainFetchedResultsControllerLoaded;

@end
