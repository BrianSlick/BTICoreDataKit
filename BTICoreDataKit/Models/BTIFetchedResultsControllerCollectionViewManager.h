//
//  BTICoreDataKit -- [https://github.com/BriTerIdeas/BTICoreDataKit]
//  v1.2
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 It is very rare that NSFetchedResultsControllerDelegate methods need to be customized. This means copy-pasting a lot of code that winds up being the same in all kinds of places.  The purpose of this class is to remove the need to do so.  This class becomes the delegate of the supplied FRC, and then takes care of updating the supplied collection view.
 
 The intended use is to create an instance of this class, feed it a FRC and a collection view, then stick it into a property. It should run on automatic after that.
 
 If your class would still like to receive NSFetchedResultsControllerDelegate callbacks, supply yourself as the auxiliaryFetchedResultsControllerDelegate. The callbacks will be forwarded. NOTE: Doing so does not change how this class works.
 
 */


// Libraries
@import UIKit;
@import CoreData;

// Classes and Forward Declarations
#import "BTIObject.h"

// Public Constants

@interface BTIFetchedResultsControllerCollectionViewManager : BTIObject

#pragma mark - Public Properties

/// A NSFetchedResultsController to manage. This class will become the delegate of the FRC.
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

/// A collection view to manage. This class will update the collection view in response to FRC changes.
@property (nonatomic, weak) UICollectionView *collectionView;

/// If an auxiliary delegate is supplied, FRC delegate methods will be forwarded. Implementing the appropriate methods does NOT change what this class does. This is merely an avenue to be informed of FRC changes, for situations where a response over and above what this class does is needed. The auxiliary delegate will be notified before this class performs any operations.
@property (nonatomic, weak) id<NSFetchedResultsControllerDelegate, NSObject> auxiliaryFetchedResultsControllerDelegate;

#pragma mark - Public Methods

@end
