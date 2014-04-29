//
//  BTICoreDataTableViewController.m
//  BTICoreDataKit
//
//  Created by Brian Slick in April 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTICoreDataKit
//

#import "BTICoreDataTableViewController.h"

// Models and other global
#import "BTICoreDataKit.h"

// Sub-controllers

// Views

// Private Constants

@interface BTICoreDataTableViewController ()

// Private Properties
@property (nonatomic, strong) BTIFetchedResultsControllerTableViewManager *mainTableViewManager;
@property (nonatomic, strong) BTIFetchedResultsControllerTableViewManager *searchTableViewManager;

@end

@implementation BTICoreDataTableViewController

#pragma mark - Synthesized Properties

// These are needed for instance variables since both getter and setter are manually overriden
@synthesize mainFetchedResultsController = _mainFetchedResultsController;
@synthesize searchFetchedResultsController = _searchFetchedResultsController;

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
    [[self mainTableViewManager] setFetchedResultsController:mainFetchedResultsController];
    
    _mainFetchedResultsController = mainFetchedResultsController;
}

- (NSFetchedResultsController *)searchFetchedResultsController
{
    if (_searchFetchedResultsController == nil)
    {
        [self loadSearchFetchedResultsController];
    }
    
    return _searchFetchedResultsController;
}

- (void)setSearchFetchedResultsController:(NSFetchedResultsController *)searchFetchedResultsController
{
    [[self searchTableViewManager] setFetchedResultsController:searchFetchedResultsController];
    
    _searchFetchedResultsController = searchFetchedResultsController;
}

- (BTIFetchedResultsControllerTableViewManager *)mainTableViewManager
{
    if (_mainTableViewManager == nil)
    {
        _mainTableViewManager = [[BTIFetchedResultsControllerTableViewManager alloc] init];
    }
    return _mainTableViewManager;
}

- (BTIFetchedResultsControllerTableViewManager *)searchTableViewManager
{
    if (_searchTableViewManager == nil)
    {
        _searchTableViewManager = [[BTIFetchedResultsControllerTableViewManager alloc] init];
    }
    return _searchTableViewManager;
}

#pragma mark - UIViewController Overrides

- (void)viewDidLoad
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [super viewDidLoad];
    
    [[self mainTableViewManager] setTableView:[self tableView]];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTIViewController Overrides


#pragma mark - BTITableViewController Overrides

- (id)itemInTableView:(UITableView *)tableView
          atIndexPath:(NSIndexPath *)indexPath
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSFetchedResultsController *controller = [self fetchedResultsControllerForTableView:tableView];
    
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

- (void)loadSearchFetchedResultsController
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    // Subclasses should override, do not need to call super
    // Subclass implementation should populate the searchFetchedResultsController property
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (NSFetchedResultsController *)fetchedResultsControllerForTableView:(UITableView *)tableView
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSFetchedResultsController *controller = nil;
    
    if (tableView == [self tableView])
    {
        controller = [self mainFetchedResultsController];
    }
    else if (tableView == [[self searchDisplayController] searchResultsTableView])
    {
        controller = [self searchFetchedResultsController];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return controller;
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSFetchedResultsController *controller = [self fetchedResultsControllerForTableView:tableView];
    
    NSInteger sections = [[controller sections] count];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSFetchedResultsController *controller = [self fetchedResultsControllerForTableView:tableView];
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[controller sections] objectAtIndex:section];
    
    NSInteger rows = [sectionInfo numberOfObjects];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    // Build Cell
    
    static NSString *blankCellIdentifier = @"blankCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:blankCellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:blankCellIdentifier];
    }
    
    // Acquire Data
    
    id rowObject = [self itemInTableView:tableView atIndexPath:indexPath];
    
    // Populate Cell
    
    [[cell textLabel] setText:[rowObject description]];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return cell;
}

#pragma mark - UITableViewDelegate Methods


#pragma mark - UISearchDisplayDelegate Methods

- (void)searchDisplayController:(UISearchDisplayController *)controller
  didLoadSearchResultsTableView:(UITableView *)tableView
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [[self searchTableViewManager] setTableView:tableView];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)searchDisplayController:(UISearchDisplayController *)controller
willUnloadSearchResultsTableView:(UITableView *)tableView
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [[self searchTableViewManager] setTableView:nil];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}


@end
