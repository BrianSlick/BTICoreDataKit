//
//  BTITableViewController.m
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "BTIArrayTableViewController.h"

// Models and other global
#import "BTIMacros.h"

// Sub-controllers

// Views

// Private Constants

@interface BTIArrayTableViewController ()

// Private Properties
@property (nonatomic, strong) NSMutableArray *mainContents;
@property (nonatomic, strong) NSMutableArray *searchContents;

@end

@implementation BTIArrayTableViewController

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

- (NSMutableArray *)searchContents
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

- (id)itemInTableView:(UITableView *)tableView
          atIndexPath:(NSIndexPath *)indexPath
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSInteger row = [indexPath row];
    
    id object = nil;
    
    if (tableView == [self tableView])
    {
        // Main contents
        object = [[self mainContents] objectAtIndex:row];
    }
    else if (tableView == [[self searchDisplayController] searchResultsTableView])
    {
        // Search contents
        object = [[self searchContents] objectAtIndex:row];
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
    
    if (tableView == [self tableView])
    {
        rows = [[self mainContents] count];
    }
    else
    {
        rows = [[self searchContents] count];
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


#pragma mark - UISearchDisplayDelegate Methods


@end
