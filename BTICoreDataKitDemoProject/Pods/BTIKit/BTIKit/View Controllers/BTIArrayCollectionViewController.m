//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "BTIArrayCollectionViewController.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// View Controllers

// Views

// Private Constants

@interface BTIArrayCollectionViewController ()

// Private Properties
@property (nonatomic, strong) NSMutableArray *mainContents;

@end

@implementation BTIArrayCollectionViewController

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Methods


#pragma mark - Initialization and UI Creation Methods


#pragma mark - Custom Getters and Setters

- (NSMutableArray *)mainContents
{
    if (_mainContents == nil)
    {
        _mainContents = [[NSMutableArray alloc] init];
    }
    return _mainContents;
}

#pragma mark - UIViewController Overrides


#pragma mark - BTIViewController Overrides


#pragma mark - BTICollectionViewController Overrides

- (id)itemInCollectionView:(UICollectionView *)collectionView
               atIndexPath:(NSIndexPath *)indexPath
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    NSInteger row = [indexPath row];
    
    id object = nil;
    
    if (collectionView == [self collectionView])
    {
        object = [[self mainContents] objectAtIndex:row];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return object;
}

#pragma mark - Notification Handlers


#pragma mark - UI Response Methods


#pragma mark - Misc Methods


#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSInteger items = 0;
    
    if (collectionView == [self collectionView])
    {
        items = [[self mainContents] count];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return items;
}

#pragma mark - UICollectionViewDelegate Methods

@end
