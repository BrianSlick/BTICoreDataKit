//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "BTITableViewController.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// View Controllers

// Views

// Private Constants

@interface BTITableViewController ()

// Private Properties
@property (nullable, nonatomic, strong) UISearchController *searchController;
@property (nonnull, nonatomic, strong) NSMutableSet *selectionSet;

@end

@implementation BTITableViewController

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Methods

- (void)dealloc
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [_tableView setDataSource:nil];
    [_tableView setDelegate:nil];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Initialization and UI Creation Methods


#pragma mark - Custom Getters and Setters

- (nonnull NSMutableSet *)selectionSet
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
    
    UITableView *tableView = [self tableView];
    NSAssert(tableView != nil, @"Table view was not created");
    
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    [self registerNibsForTableView:tableView];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)setEditing:(BOOL)editing
          animated:(BOOL)animated
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [super setEditing:editing animated:animated];
    
    [[self tableView] setEditing:editing animated:animated];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTIViewController Overrides


#pragma mark - Notification Handlers


#pragma mark - UI Response Methods


#pragma mark - Misc Methods

- (void)handleSearchForTerm:(nullable NSString *)searchTerm
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [self setSavedSearchTerm:searchTerm];
    
    // Subclasses should override and call super
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (nullable id)itemInTableView:(nullable UITableView *)tableView
                   atIndexPath:(nullable NSIndexPath *)indexPath
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    id object = nil;
    
    // Sample usage
    
    //    if ([[self searchController] isActive])
    //    {
    //        // Search contents
    //        object = <something from search array>;
    //    }
    //    else
    //    {
    //        // Main contents
    //        object = <something from primary array>;
    //    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return object;
}

- (void)registerNibsForTableView:(nullable UITableView *)tableView
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    // Deliberately blank. Subclasses should override, no need to call super.
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)setSearchInterfaceVisible:(BOOL)isVisible
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (isVisible)
    {
        UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        [self setSearchController:searchController];
        
        [searchController setSearchResultsUpdater:self];
        [searchController setDimsBackgroundDuringPresentation:NO];
        
        UISearchBar *searchBar = [searchController searchBar];
        [[self tableView] setTableHeaderView:searchBar];
        [searchBar sizeToFit];
        
        [self setDefinesPresentationContext:YES];
    }
    else
    {
        UISearchController *searchController = [self searchController];
        [searchController setActive:NO];
        [searchController setDelegate:nil];
        [searchController setSearchResultsUpdater:nil];
        [[self tableView] setTableHeaderView:nil];
        
        [self setSearchController:nil];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Sample"];
    
    [[cell textLabel] setText:@"Must Override In Subclass"];
    
    return cell;
}

#pragma mark - UITableViewDelegate Methods


#pragma mark - UISearchResultsUpdating Methods

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSString *searchString = [[searchController searchBar] text];
    
    [self handleSearchForTerm:searchString];
    
    [[self tableView] reloadData];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
