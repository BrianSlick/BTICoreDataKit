//
//  BTICoreDataKit -- [https://github.com/BriTerIdeas/BTICoreDataKit]
//  v1.3
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "BTICoreDataCollectionViewController.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// View Controllers

// Views

// Private Constants

@interface BTICoreDataCollectionViewController ()

// Private Properties
@property (nonatomic, strong) BTIFetchedResultsControllerCollectionViewManager *mainCollectionViewManager;

@end

@implementation BTICoreDataCollectionViewController

#pragma mark - Synthesized Properties

// Needed for instance variables since both getter and setter are manually overriden
@synthesize mainFetchedResultsController = _mainFetchedResultsController;

#pragma mark - Dealloc and Memory Methods


#pragma mark - Initialization and UI Creation Methods


#pragma mark - Custom Getters and Setters

- (NSFetchedResultsController *)mainFetchedResultsController
{
    if (_mainFetchedResultsController == nil)
    {
        [self loadMainFetchedResultsController];
    }
    
    return _mainFetchedResultsController;
}

- (void)setMainFetchedResultsController:(NSFetchedResultsController *)mainFetchedResultsController
{
    [[self mainCollectionViewManager] setFetchedResultsController:mainFetchedResultsController];
    
    _mainFetchedResultsController = mainFetchedResultsController;
}

- (BTIFetchedResultsControllerCollectionViewManager *)mainCollectionViewManager
{
    if (_mainCollectionViewManager == nil)
    {
        _mainCollectionViewManager = [[BTIFetchedResultsControllerCollectionViewManager alloc] init];
    }
    return _mainCollectionViewManager;
}

#pragma mark - UIViewController Overrides

- (void)viewDidLoad
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [super viewDidLoad];
    
    [[self mainCollectionViewManager] setCollectionView:[self collectionView]];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTIViewController Overrides


#pragma mark - BTICollectionViewController Overrides

- (id)itemInCollectionView:(UICollectionView *)collectionView
               atIndexPath:(NSIndexPath *)indexPath
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSFetchedResultsController *controller = [self fetchedResultsControllerForCollectionView:collectionView];
    
    id object = [controller objectAtIndexPath:indexPath];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return object;
}

#pragma mark - Notification Handlers


#pragma mark - UI Response Methods


#pragma mark - Misc Methods

- (void)loadMainFetchedResultsController
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    // Subclasses should override, do not need to call super
    // Subclass implementation should populate the mainFetchedResultsController property
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (NSFetchedResultsController *)fetchedResultsControllerForCollectionView:(UICollectionView *)collectionView
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    NSFetchedResultsController *controller = nil;

    if (collectionView == [self collectionView])
    {
        controller = [self mainFetchedResultsController];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return controller;
}

- (BOOL)isMainFetchedResultsControllerLoaded
{
    return (_mainFetchedResultsController != nil);
}

#pragma mark - UICollectionViewDataSource Methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    NSFetchedResultsController *controller = [self fetchedResultsControllerForCollectionView:collectionView];
    
    NSInteger sections = [[controller sections] count];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return sections;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSFetchedResultsController *controller = [self fetchedResultsControllerForCollectionView:collectionView];
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[controller sections] objectAtIndex:section];
    
    NSInteger rows = [sectionInfo numberOfObjects];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return rows;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [[UICollectionViewCell alloc] init];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate Methods

@end
