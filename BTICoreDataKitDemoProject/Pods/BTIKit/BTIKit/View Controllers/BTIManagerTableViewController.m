//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "BTIManagerTableViewController.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// View Controllers

// Views

// Private Constants

@interface BTIManagerTableViewController ()

// Private Properties
@property (nonatomic, strong) BTITableContentsManager *mainContentsManager;
@property (nonatomic, strong) BTITableContentsManager *searchContentsManager;

@end

@implementation BTIManagerTableViewController

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Methods


#pragma mark - Initialization and UI Creation Methods


#pragma mark - Custom Getters and Setters

- (BTITableContentsManager *)mainContentsManager
{
    if (_mainContentsManager == nil)
    {
        _mainContentsManager = [[BTITableContentsManager alloc] init];
    }
    
    return _mainContentsManager;
}

- (BTITableContentsManager *)searchContentsManager
{
    if (_searchContentsManager == nil)
    {
        _searchContentsManager = [[BTITableContentsManager alloc] init];
    }
    
    return _searchContentsManager;
}

#pragma mark - UIViewController Overrides


#pragma mark - BTIViewController Overrides


#pragma mark - BTITableViewController Overrides


#pragma mark - Notification Handlers


#pragma mark - UI Response Methods


#pragma mark - Misc Methods

- (BTITableContentsManager *)contentsManagerForTableView:(UITableView *)tableView
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    BTITableContentsManager *manager = nil;
    
    if (tableView == [self tableView])
    {
        manager = [self mainContentsManager];
    }
    else if (tableView == [[self searchDisplayController] searchResultsTableView])
    {
        manager = [self searchContentsManager];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return manager;
}

- (BTITableSectionInfo *)sectionInfoInTableView:(UITableView *)tableView
                                        atIndex:(NSUInteger)index
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    BTITableContentsManager *manager = [self contentsManagerForTableView:tableView];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [manager sectionInfoAtIndex:index];
}

- (BTITableRowInfo *)rowInfoInTableView:(UITableView *)tableView
                            atIndexPath:(NSIndexPath *)indexPath
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    BTITableContentsManager *manager = [self contentsManagerForTableView:tableView];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [manager rowInfoAtIndexPath:indexPath];
}

- (id)representedObjectInTableView:(UITableView *)tableView
                       atIndexPath:(NSIndexPath *)indexPath
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    BTITableContentsManager *manager = [self contentsManagerForTableView:tableView];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [manager representedObjectAtIndexPath:indexPath];
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    BTITableContentsManager *manager = [self contentsManagerForTableView:tableView];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [manager numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    BTITableContentsManager *manager = [self contentsManagerForTableView:tableView];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [manager numberOfRowsInSection:section];
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
    
    id rowObject = [self representedObjectInTableView:tableView atIndexPath:indexPath];
    
    // Populate Cell
    
    [[cell textLabel] setText:[rowObject description]];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return cell;
}

#pragma mark - UITableViewDelegate Methods


#pragma mark - UISearchDisplayDelegate Methods


@end
