//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
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
@property (nonatomic, strong) NSMutableSet *selectionSet;

@end

@implementation BTITableViewController

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Methods

- (void)dealloc
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    // Clear delegates and other global references
    [_tableView setDataSource:nil];
    [_tableView setDelegate:nil];
        
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
    
    UITableView *tableView = [self tableView];
    if (tableView == nil)
    {
        UIView *mainView = [self view];
        
        tableView = [[UITableView alloc] initWithFrame:[mainView bounds] style:UITableViewStylePlain];
        [tableView setAutoresizingMask:[mainView autoresizingMask]];
        
        [mainView addSubview:tableView];
        
        [self setTableView:tableView];
    }
    
    [tableView setDelegate:self];
    [tableView setDataSource:self];
    
    UISearchDisplayController *searchController = [self searchDisplayController];
    [searchController setDelegate:self];
    [searchController setSearchResultsDataSource:self];
    [searchController setSearchResultsDelegate:self];

    [self registerNibsForTableView:tableView];

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)setEditing:(BOOL)editing
          animated:(BOOL)animated
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [super setEditing:editing animated:animated];
    
    [[self tableView] setEditing:editing animated:animated];
    [[[self searchDisplayController] searchResultsTableView] setEditing:editing animated:animated];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTIViewController Overrides


#pragma mark - Notification Handlers


#pragma mark - UI Response Methods


#pragma mark - Misc Methods

- (void)handleSearchForTerm:(NSString *)searchTerm
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [self setSavedSearchTerm:searchTerm];
    
    // Subclasses should override and call super
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (id)itemInTableView:(UITableView *)tableView
          atIndexPath:(NSIndexPath *)indexPath
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    id object = nil;
    
    // Sample usage
    
//    if (tableView == [self tableView])
//    {
//        // Main contents
//        object = <something from primary array>;
//    }
//    else if (tableView == [[self searchDisplayController] searchResultsTableView])
//    {
//        // Search contents
//        object = <something from search array>;
//    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return object;
}

- (void)registerNibsForTableView:(UITableView *)tableView
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    // Deliberately blank. Subclasses should override, no need to call super.
    
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


#pragma mark - UISearchDisplayDelegate Methods

- (void)searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [[self tableView] reloadData];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [self handleSearchForTerm:searchString];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return YES;
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [self setSavedSearchTerm:nil];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
