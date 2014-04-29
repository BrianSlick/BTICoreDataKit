//
//  BTIFetchedResultsControllerTableViewManager.m
//  BTICoreDataKit
//
//  Created by Brian Slick in April 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTICoreDataKit
//
// FRC update scheme from
// http://www.fruitstandsoftware.com/blog/2013/02/uitableview-and-nsfetchedresultscontroller-updates-done-right/

#import "BTIFetchedResultsControllerTableViewManager.h"

#import "BTICoreDataKit.h"

@interface BTIFetchedResultsControllerTableViewManager () <NSFetchedResultsControllerDelegate>

// Private Properties
@property (nonatomic, strong) NSMutableIndexSet *deletedSectionIndexes;
@property (nonatomic, strong) NSMutableIndexSet *insertedSectionIndexes;
@property (nonatomic, strong) NSMutableArray *deletedRowIndexPaths;
@property (nonatomic, strong) NSMutableArray *insertedRowIndexPaths;
@property (nonatomic, strong) NSMutableArray *updatedRowIndexPaths;

@end

@implementation BTIFetchedResultsControllerTableViewManager

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

- (NSMutableArray *)deletedRowIndexPaths
{
    if (_deletedRowIndexPaths == nil)
    {
        _deletedRowIndexPaths = [[NSMutableArray alloc] init];
    }
    return _deletedRowIndexPaths;
}

- (NSMutableArray *)insertedRowIndexPaths
{
    if (_insertedRowIndexPaths == nil)
    {
        _insertedRowIndexPaths = [[NSMutableArray alloc] init];
    }
    return _insertedRowIndexPaths;
}

- (NSMutableArray *)updatedRowIndexPaths
{
    if (_updatedRowIndexPaths == nil)
    {
        _updatedRowIndexPaths = [[NSMutableArray alloc] init];
    }
    return _updatedRowIndexPaths;
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
            
            [[self insertedRowIndexPaths] addObject:newIndexPath];
        }
            break;
        case NSFetchedResultsChangeDelete:
        {
            if ([[self deletedSectionIndexes] containsIndex:section])
            {
                //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Will be handled by section deletion", self, __PRETTY_FUNCTION__);
                return;
            }
            
            [[self deletedRowIndexPaths] addObject:indexPath];
        }
            break;
        case NSFetchedResultsChangeMove:
        {
            if (![[self insertedSectionIndexes] containsIndex:newSection])
            {
                [[self insertedRowIndexPaths] addObject:newIndexPath];
            }
            
            if (![[self deletedSectionIndexes] containsIndex:section])
            {
                [[self deletedRowIndexPaths] addObject:indexPath];
            }
        }
            break;
        case NSFetchedResultsChangeUpdate:
        {
            [[self updatedRowIndexPaths] addObject:indexPath];
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
    
    UITableView *tableView = [self tableView];
    
    NSInteger totalChanges = [[self deletedSectionIndexes] count] + [[self insertedSectionIndexes] count] + [[self deletedRowIndexPaths] count] + [[self insertedRowIndexPaths] count] + [[self updatedRowIndexPaths] count];
    
    if (totalChanges > 50)
    {
        [tableView reloadData];
    }
    else
    {
        [tableView beginUpdates];
        
        [tableView deleteSections:[self deletedSectionIndexes] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView insertSections:[self insertedSectionIndexes] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [tableView deleteRowsAtIndexPaths:[self deletedRowIndexPaths] withRowAnimation:UITableViewRowAnimationLeft];
        [tableView insertRowsAtIndexPaths:[self insertedRowIndexPaths] withRowAnimation:UITableViewRowAnimationRight];
        [tableView reloadRowsAtIndexPaths:[self updatedRowIndexPaths] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [tableView endUpdates];
    }
    
    [self setInsertedSectionIndexes:nil];
    [self setDeletedSectionIndexes:nil];
    
    [self setDeletedRowIndexPaths:nil];
    [self setInsertedRowIndexPaths:nil];
    [self setUpdatedRowIndexPaths:nil];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (NSString *)controller:(NSFetchedResultsController *)controller
sectionIndexTitleForSectionName:(NSString *)sectionName
{
    if ([[self auxiliaryFetchedResultsControllerDelegate] respondsToSelector:@selector(controller:sectionIndexTitleForSectionName:)])
    {
        return [[self auxiliaryFetchedResultsControllerDelegate] controller:controller
                                            sectionIndexTitleForSectionName:sectionName];
    }
    
    return nil;
}

@end
