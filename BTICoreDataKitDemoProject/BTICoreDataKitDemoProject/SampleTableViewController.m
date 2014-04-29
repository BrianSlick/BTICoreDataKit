//
//  SampleTableViewController.m
//  BTICoreDataKitDemoProject
//
//  Created by Brian Slick on 4/23/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import "SampleTableViewController.h"

// Models and other global
#import "BTICoreDataKit.h"
#import "DemoPerson.h"

// Sub-controllers

// Views

// Private Constants

@interface SampleTableViewController ()

// Private Properties

@end

@implementation SampleTableViewController

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Methods


#pragma mark - Initialization and UI Creation Methods


#pragma mark - Custom Getters and Setters


#pragma mark - UIViewController Overrides

- (void)viewDidLoad
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [super viewDidLoad];
    
    [self setTitle:@"People"];
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                               target:self
                                                                               action:@selector(addButtonPressed:)];
    [[self navigationItem] setRightBarButtonItem:addButton];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)viewWillAppear:(BOOL)animated
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [super viewWillAppear:animated];
    
    BTICoreDataStackManager *coreDataManager = [BTICoreDataStackManager sharedCoreDataStackManager];
    [coreDataManager loadPersistentStore];
    
    [self setManagedObjectContext:[coreDataManager mainThreadContext]];
    
    [[self tableView] reloadData];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTITableViewController Overrides

- (void)handleSearchForTerm:(NSString *)searchTerm
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [super handleSearchForTerm:searchTerm];
    
    [self setSearchFetchedResultsController:nil];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTICoreDataTableViewController Overrides

- (void)loadMainFetchedResultsController
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    [fetchRequest setEntity:[DemoPerson entityDescriptionInContextBTI:context]];
    
    NSSortDescriptor *firstNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"firstName" ascending:YES selector:@selector(localizedStandardCompare:)];
    NSSortDescriptor *lastNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastName" ascending:YES selector:@selector(localizedStandardCompare:)];
    
    [fetchRequest setSortDescriptors:@[ firstNameDescriptor, lastNameDescriptor ]];
    
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                 managedObjectContext:context
                                                                                   sectionNameKeyPath:nil
                                                                                            cacheName:nil];
    [self setMainFetchedResultsController:controller];
    
    [controller performFetchBTI];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)loadSearchFetchedResultsController
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSString *searchTerm = [self savedSearchTerm];
    
    if ([searchTerm length] == 0)
    {
        [self setSearchFetchedResultsController:nil];
        
        BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - No search criteria", self, __PRETTY_FUNCTION__);
        return;
    }
    
    NSFetchedResultsController *mainController = [self mainFetchedResultsController];
    
    NSFetchRequest *fetchRequest = [mainController fetchRequest];
    
    NSPredicate *firstNamePredicate = [NSPredicate predicateWithFormat:@"firstName CONTAINS[c] %@", searchTerm];
    NSPredicate *lastNamePredicate = [NSPredicate predicateWithFormat:@"lastName CONTAINS[c] %@", searchTerm];
    
    NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[ firstNamePredicate, lastNamePredicate ]];
    [fetchRequest setPredicate:predicate];
    
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                 managedObjectContext:[mainController managedObjectContext]
                                                                                   sectionNameKeyPath:nil
                                                                                            cacheName:nil];
    [self setSearchFetchedResultsController:controller];
    
    [controller performFetchBTI];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Notification Handlers


#pragma mark - UI Response Methods

- (void)addButtonPressed:(UIBarButtonItem *)button
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSArray *firstNames = @[ @"Bob", @"Tom", @"Chick", @"Kristy", @"Jason", @"Gunner", @"Scott" ];
    NSArray *lastNames = @[ @"Kevoian", @"Griswold", @"McGee", @"Lee", @"Potasnik" ];
    
    NSString *firstName = [firstNames objectAtIndex:arc4random() % [firstNames count]];
    NSString *lastName = [lastNames objectAtIndex:arc4random() % [lastNames count]];
    
    NSManagedObjectContext *context = [self managedObjectContext];
    
    DemoPerson *person = [DemoPerson newManagedObjectInContextBTI:context];
    [person setFirstName:firstName];
    [person setLastName:lastName];
    
    [context saveBTI];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Misc Methods


#pragma mark - UITableViewDataSource Methods

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    // Build Cell
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Acquire Data
    
    DemoPerson *person = [self itemInTableView:tableView atIndexPath:indexPath];
    NSString *fullName = [NSString stringWithFormat:@"%@ %@", [person firstName], [person lastName]];
    
    // Populate Cell
    
    [[cell textLabel] setText:fullName];
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return cell;
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        DemoPerson *person = [self itemInTableView:tableView atIndexPath:indexPath];
        
        NSManagedObjectContext *context = [person managedObjectContext];
        
        [context deleteObject:person];
        
        [context saveBTI];
    }
    
    BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - UITableViewDelegate Methods




@end
