//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "BTICollectionViewController.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// View Controllers

// Views

// Private Constants

@interface BTICollectionViewController ()

// Private Properties
@property (nonatomic, strong) NSMutableSet *selectionSet;

@end

@implementation BTICollectionViewController

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Methods

- (void)dealloc
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    // Clear delegates and other global references
    [_collectionView setDataSource:nil];
    [_collectionView setDelegate:nil];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Initialization and UI Creation Methods


#pragma mark - Custom Getters and Setters

- (NSMutableSet *)selectionSet
{
    if (_selectionSet == nil)
    {
        _selectionSet = [[NSMutableSet alloc] init];
    }
    return _selectionSet;
}

#pragma mark - UIViewController Overrides

- (void)viewDidLoad
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [super viewDidLoad];
    
    UICollectionView *collectionView = [self collectionView];
    if (collectionView == nil)
    {
        UIView *mainView = [self view];
        
        collectionView = [[UICollectionView alloc] initWithFrame:[mainView bounds]];
        [collectionView setAutoresizingMask:[mainView autoresizingMask]];
        
        [mainView addSubview:collectionView];
        
        [self setCollectionView:collectionView];
    }
    
    [collectionView setDelegate:self];
    [collectionView setDataSource:self];
    
    [self registerNibsForCollectionView:collectionView];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTIViewController Overrides


#pragma mark - Notification Handlers


#pragma mark - UI Response Methods


#pragma mark - Misc Methods

- (id)itemInCollectionView:(UICollectionView *)collectionView
               atIndexPath:(NSIndexPath *)indexPath
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    id object = nil;
    
    // Sample usage
    
    //    if (tableView == [self collectionView])
    //    {
    //        // Main contents
    //        object = <something from primary array>;
    //    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return object;
}

- (void)registerNibsForCollectionView:(UICollectionView *)collectionView
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    // Deliberately blank. Subclasses should override, no need to call super.
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [[UICollectionViewCell alloc] init];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate Methods

@end
