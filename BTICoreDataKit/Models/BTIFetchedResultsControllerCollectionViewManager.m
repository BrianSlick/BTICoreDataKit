//
//  BTICoreDataKit -- [https://github.com/BriTerIdeas/BTICoreDataKit]
//  v1.3
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//
// FRC update scheme from
// http://www.fruitstandsoftware.com/blog/2013/02/uitableview-and-nsfetchedresultscontroller-updates-done-right/

#import "BTIFetchedResultsControllerCollectionViewManager.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// Private Constants

@interface BTIFetchedResultsControllerCollectionViewManager () <NSFetchedResultsControllerDelegate>

// Private Properties
@property (nonatomic, strong) NSMutableIndexSet *deletedSectionIndexes;
@property (nonatomic, strong) NSMutableIndexSet *insertedSectionIndexes;
@property (nonatomic, strong) NSMutableArray *deletedItemIndexPaths;
@property (nonatomic, strong) NSMutableArray *insertedItemIndexPaths;
@property (nonatomic, strong) NSMutableArray *updatedItemIndexPaths;

@end

@implementation BTIFetchedResultsControllerCollectionViewManager

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Management

- (void)dealloc
{
    [_fetchedResultsController setDelegate:nil];
}

#pragma mark - Custom Getters and Setters

- (void)setFetchedResultsController:(NSFetchedResultsController *)fetchedResultsController
{
    [_fetchedResultsController setDelegate:nil];
    
    [fetchedResultsController setDelegate:self];
    _fetchedResultsController = fetchedResultsController;
}

- (NSMutableIndexSet *)deletedSectionIndexes
{
    if (_deletedSectionIndexes == nil)
    {
        _deletedSectionIndexes = [[NSMutableIndexSet alloc] init];
    }
    return _deletedSectionIndexes;
}

- (NSMutableIndexSet *)insertedSectionIndexes
{
    if (_insertedSectionIndexes == nil)
    {
        _insertedSectionIndexes = [[NSMutableIndexSet alloc] init];
    }
    return _insertedSectionIndexes;
}

- (NSMutableArray *)deletedItemIndexPaths
{
    if (_deletedItemIndexPaths == nil)
    {
        _deletedItemIndexPaths = [[NSMutableArray alloc] init];
    }
    return _deletedItemIndexPaths;
}

- (NSMutableArray *)insertedItemIndexPaths
{
    if (_insertedItemIndexPaths == nil)
    {
        _insertedItemIndexPaths = [[NSMutableArray alloc] init];
    }
    return _insertedItemIndexPaths;
}

- (NSMutableArray *)updatedItemIndexPaths
{
    if (_updatedItemIndexPaths == nil)
    {
        _updatedItemIndexPaths = [[NSMutableArray alloc] init];
    }
    return _updatedItemIndexPaths;
}

#pragma mark - Initialization


#pragma mark - NSFetchedResultsControllerDelegate methods

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if ([[self auxiliaryFetchedResultsControllerDelegate] respondsToSelector:@selector(controllerWillChangeContent:)])
    {
        [[self auxiliaryFetchedResultsControllerDelegate] controllerWillChangeContent:controller];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)controller:(NSFetchedResultsController *)controller
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if ([[self auxiliaryFetchedResultsControllerDelegate] respondsToSelector:@selector(controller:didChangeObject:atIndexPath:forChangeType:newIndexPath:)])
    {
        [[self auxiliaryFetchedResultsControllerDelegate] controller:controller
                                                     didChangeObject:anObject
                                                         atIndexPath:indexPath
                                                       forChangeType:type
                                                        newIndexPath:newIndexPath];
    }
    
    NSInteger section = [indexPath section];
    NSInteger newSection = [newIndexPath section];
    
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
        {
            if ([[self insertedSectionIndexes] containsIndex:newSection])
            {
                //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Will be handled by section insertion", self, __PRETTY_FUNCTION__);
                return;
            }
            
            [[self insertedItemIndexPaths] addObject:newIndexPath];
        }
            break;
        case NSFetchedResultsChangeDelete:
        {
            if ([[self deletedSectionIndexes] containsIndex:section])
            {
                //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Will be handled by section deletion", self, __PRETTY_FUNCTION__);
                return;
            }
            
            [[self deletedItemIndexPaths] addObject:indexPath];
        }
            break;
        case NSFetchedResultsChangeMove:
        {
            if (![[self insertedSectionIndexes] containsIndex:newSection])
            {
                [[self insertedItemIndexPaths] addObject:newIndexPath];
            }
            
            if (![[self deletedSectionIndexes] containsIndex:section])
            {
                [[self deletedItemIndexPaths] addObject:indexPath];
            }
        }
            break;
        case NSFetchedResultsChangeUpdate:
        {
            [[self updatedItemIndexPaths] addObject:indexPath];
        }
            break;
        default:
            break;
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)controller:(NSFetchedResultsController *)controller
  didChangeSection:(id )sectionInfo
           atIndex:(NSUInteger)sectionIndex
     forChangeType:(NSFetchedResultsChangeType)type
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if ([[self auxiliaryFetchedResultsControllerDelegate] respondsToSelector:@selector(controller:didChangeSection:atIndex:forChangeType:)])
    {
        [[self auxiliaryFetchedResultsControllerDelegate] controller:controller
                                                    didChangeSection:sectionInfo
                                                             atIndex:sectionIndex
                                                       forChangeType:type];
    }
    
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
        {
            [[self insertedSectionIndexes] addIndex:sectionIndex];
        }
            break;
        case NSFetchedResultsChangeDelete:
        {
            [[self deletedSectionIndexes] addIndex:sectionIndex];
        }
            break;
        default:
            break;
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if ([[self auxiliaryFetchedResultsControllerDelegate] respondsToSelector:@selector(controllerDidChangeContent:)])
    {
        [[self auxiliaryFetchedResultsControllerDelegate] controllerDidChangeContent:controller];
    }
    
    UICollectionView *collectionView = [self collectionView];
    
    NSInteger totalChanges = [[self deletedSectionIndexes] count] + [[self insertedSectionIndexes] count] + [[self deletedItemIndexPaths] count] + [[self insertedItemIndexPaths] count] + [[self updatedItemIndexPaths] count];
    
    if (totalChanges > 50)
    {
        [collectionView reloadData];
    }
    else
    {
        [collectionView performBatchUpdates:^{
            
            [collectionView deleteSections:[self deletedSectionIndexes]];
            [collectionView insertSections:[self insertedSectionIndexes]];
            
            [collectionView deleteItemsAtIndexPaths:[self deletedItemIndexPaths]];
            [collectionView insertItemsAtIndexPaths:[self insertedItemIndexPaths]];
            [collectionView reloadItemsAtIndexPaths:[self updatedItemIndexPaths]];
            
        }
                                 completion:^(BOOL finished) {
                                     
                                     if (!finished)
                                     {
                                         [collectionView reloadData];
                                     }
                                     
                                 }];
    }
    
    [self setInsertedSectionIndexes:nil];
    [self setDeletedSectionIndexes:nil];
    
    [self setDeletedItemIndexPaths:nil];
    [self setInsertedItemIndexPaths:nil];
    [self setUpdatedItemIndexPaths:nil];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
