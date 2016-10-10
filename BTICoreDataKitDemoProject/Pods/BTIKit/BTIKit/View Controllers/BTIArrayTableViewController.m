//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "BTIArrayTableViewController.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// View Controllers

// Views

// Private Constants

@interface BTIArrayTableViewController ()

// Private Properties
@property (nonnull, nonatomic, strong) NSMutableArray *mainContents;
@property (nonnull, nonatomic, strong) NSMutableArray *searchContents;

@end

@implementation BTIArrayTableViewController

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Methods


#pragma mark - Initialization and UI Creation Methods


#pragma mark - Custom Getters and Setters

- (nonnull NSMutableArray *)mainContents
{
    if (_mainContents == nil)
    {
        _mainContents = [[NSMutableArray alloc] init];
    }
    return _mainContents;
}

- (nonnull NSMutableArray *)searchContents
{
    if (_searchContents == nil)
    {
        _searchContents = [[NSMutableArray alloc] init];
    }
    return _searchContents;
}

#pragma mark - UIViewController Overrides


#pragma mark - BTIViewController Overrides


#pragma mark - BTITableViewController Overrides

- (nullable id)itemInTableView:(nullable UITableView *)tableView
                   atIndexPath:(nullable NSIndexPath *)indexPath;
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSInteger row = [indexPath row];
    
    id object = nil;
    
    if ([[self searchController] isActive])
    {
        // Search contents
        object = [[self searchContents] objectAtIndex:row];
    }
    else
    {
        // Main contents
        object = [[self mainContents] objectAtIndex:row];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return object;
}

#pragma mark - Notification Handlers


#pragma mark - UI Response Methods


#pragma mark - Misc Methods


#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSInteger rows = 0;
    
    if ([[self searchController] isActive])
    {
        // Search contents
        rows = [[self searchContents] count];
    }
    else
    {
        // Main contents
        rows = [[self mainContents] count];
    }
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
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
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return cell;
}

#pragma mark - UITableViewDelegate Methods

@end
