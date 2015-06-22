//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "BTITableContentsManager.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// Private Constants
CGFloat const BTIStandardMinimumRowHeight = 44.0;

@interface BTITableContentsManager ()

// Private Properties
@property (nonatomic, strong) NSMutableArray *sectionInfos;
@property (nonatomic, strong) NSMutableSet *sectionInfoCache;
@property (nonatomic, strong) NSMutableSet *rowInfoCache;

@end

@implementation BTITableContentsManager

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Methods

- (void)dealloc
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Initialization

- (id)init
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    self = [super init];
    if (self)
    {
        [self setMinimumRowHeight:BTIStandardMinimumRowHeight];
        
        NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
        
        [notificationCenter addObserver:self
                               selector:@selector(didReceiveMemoryWarning:)
                                   name:UIApplicationDidReceiveMemoryWarningNotification
                                 object:nil];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return self;
}

#pragma mark - Custom Getters and Setters

- (NSMutableArray *)sectionInfos
{
    if (_sectionInfos == nil)
    {
        _sectionInfos = [[NSMutableArray alloc] init];
    }
    return _sectionInfos;
}

- (NSMutableSet *)sectionInfoCache
{
    if (_sectionInfoCache == nil)
    {
        _sectionInfoCache = [[NSMutableSet alloc] init];
    }
    return _sectionInfoCache;
}

- (NSMutableSet *)rowInfoCache;
{
    if (_rowInfoCache == nil)
    {
        _rowInfoCache = [[NSMutableSet alloc] init];
    }
    return _rowInfoCache;
}

#pragma mark - Notification Handlers

- (void)didReceiveMemoryWarning:(NSNotification *)notification
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [[self sectionInfoCache] removeAllObjects];
    [[self rowInfoCache] removeAllObjects];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Primary Control Methods

- (void)reset
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSArray *sectionInfos = [NSArray arrayWithArray:[self sections]];
    
    for (BTITableSectionInfo *sectionInfo in sectionInfos)
    {
        [self enqueueSectionInfo:sectionInfo];
    }
    
    [[self sectionInfos] removeAllObjects];
    
    [self setMinimumRowHeight:BTIStandardMinimumRowHeight];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (NSArray *)sections
{
    return [NSArray arrayWithArray:[self sectionInfos]];
}

#pragma mark - BTITableSectionInfo Methods

- (BTITableSectionInfo *)dequeueReusableSectionInfo
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSMutableSet *cache = [self sectionInfoCache];
    
    BTITableSectionInfo *sectionInfo = [cache anyObject];
    if (sectionInfo == nil)
    {
        sectionInfo = [[BTITableSectionInfo alloc] init];
    }
    else
    {
        [cache removeObject:sectionInfo];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return sectionInfo;
}

- (BTITableSectionInfo *)dequeueReusableSectionInfoAndAddToContents
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    BTITableSectionInfo *sectionInfo = [self dequeueReusableSectionInfo];
    
    [self addSectionInfo:sectionInfo];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return sectionInfo;
}

- (void)addSectionInfo:(BTITableSectionInfo *)sectionInfo
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (sectionInfo == nil)
    {
        //BTITrackingLog(@"<<< Leaving %s >>> EARLY - No Section provided", __PRETTY_FUNCTION__);
        return;
    }
    
    [[self sectionInfos] addObject:sectionInfo];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)enqueueSectionInfo:(BTITableSectionInfo *)sectionInfo
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (sectionInfo == nil)
    {
        //BTITrackingLog(@"<<< Leaving %s >>> EARLY - No Section provided", __PRETTY_FUNCTION__);
        return;
    }
    
    if (![sectionInfo isKindOfClass:[BTITableSectionInfo class]])
    {
        //BTITrackingLog(@"<<< Leaving %s >>> EARLY - Not a BTITableSectionInfo object", __PRETTY_FUNCTION__);
        return;
    }
    
    // Add to cache
    [[self sectionInfoCache] addObject:sectionInfo];
    
    // Capture the contents.  RowInfos need to be cached
    NSArray *rowInfos = [sectionInfo objects];
    
    // Reset the sectionInfo
    [sectionInfo reset];
    
    id anObject = [rowInfos firstObject];
    if (![anObject isKindOfClass:[BTITableRowInfo class]])
    {
        //BTITrackingLog(@"<<< Leaving %s >>> EARLY - Section contents are not row infos", __PRETTY_FUNCTION__);
        return;
    }
    
    // Cache RowInfo
    for (BTITableRowInfo *rowInfo in rowInfos)
    {
        [self enqueueRowInfo:rowInfo];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTITableRowInfoMethods

- (BTITableRowInfo *)dequeueReusableRowInfo
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSMutableSet *cache = [self rowInfoCache];
    
    BTITableRowInfo *rowInfo = [cache anyObject];
    if (rowInfo == nil)
    {
        rowInfo = [[BTITableRowInfo alloc] init];
    }
    else
    {
        [cache removeObject:rowInfo];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return rowInfo;
}

- (BTITableRowInfo *)dequeueReusableRowInfoAndAddToContents
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    NSMutableSet *cache = [self rowInfoCache];
    BTITableRowInfo *rowInfo = [cache anyObject];
    if (rowInfo == nil)
    {
        rowInfo = [[BTITableRowInfo alloc] init];
    }
    else
    {
        [cache removeObject:rowInfo];
    }

    BTITableSectionInfo *sectionInfo = [[self sections] lastObject];
    if (sectionInfo == nil)
    {
        sectionInfo = [self dequeueReusableSectionInfoAndAddToContents];
    }
    
    [sectionInfo addRowsObject:rowInfo];

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return rowInfo;
}

- (void)addRowInfo:(BTITableRowInfo *)rowInfo
    makeNewSection:(BOOL)isNewSection
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (isNewSection)
    {
        BTITableSectionInfo *sectionInfo = [self dequeueReusableSectionInfoAndAddToContents];
        
        [sectionInfo addRowsObject:rowInfo];
    }
    else
    {
        BTITableSectionInfo *sectionInfo = [[self sections] lastObject];
        if (sectionInfo == nil)
        {
            sectionInfo = [self dequeueReusableSectionInfoAndAddToContents];
        }
        
        [sectionInfo addRowsObject:rowInfo];
    }
    
    if ([[self rowInfoCache] containsObject:rowInfo])
    {
        [[self rowInfoCache] removeObject:rowInfo];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)enqueueRowInfo:(BTITableRowInfo *)rowInfo
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (rowInfo == nil)
    {
        //BTITrackingLog(@"<<< Leaving %s >>> EARLY - No Row provided", __PRETTY_FUNCTION__);
        return;
    }
    
    [[self rowInfoCache] addObject:rowInfo];
    
    [rowInfo reset];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - UITableView Support Methods

- (NSUInteger)numberOfSections
{
    return [[self sections] count];
}

- (NSString *)headerTitleInSection:(NSInteger)section
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    BTITableSectionInfo *sectionInfo = [self sectionInfoAtIndex:section];
    
    NSString *header = [sectionInfo headerTitle];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return header;
}

- (NSString *)footerTitleInSection:(NSInteger)section
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    BTITableSectionInfo *sectionInfo = [self sectionInfoAtIndex:section];
    
    NSString *footer = [sectionInfo footerTitle];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return footer;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    BTITableSectionInfo *sectionInfo = [self sectionInfoAtIndex:section];
    
    NSInteger rows = [sectionInfo countOfRows];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return rows;
}

- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    BTITableRowInfo *rowInfo = [self rowInfoAtIndexPath:indexPath];

    CGFloat height = [rowInfo rowHeight];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return MAX(height, [self minimumRowHeight]);
}

- (NSArray *)sectionIndexTitles
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    // valueForKey: will include NSNull values for any missing titles.  This will crash when passed to the table view,
    // as the array must contain only string values. To avoid this, use empty strings in place of missing titles.
    
    NSMutableArray *titles = [NSMutableArray array];
    
    for (BTITableSectionInfo *sectionInfo in [self sections])
    {
        if ([sectionInfo sectionIndexTitle] == nil)
        {
            [titles addObject:@""];
        }
        else
        {
            [titles addObject:[sectionInfo sectionIndexTitle]];
        }
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return titles;
}

#pragma mark - Content Retrieval Methods

- (BTITableSectionInfo *)sectionInfoAtIndex:(NSInteger)index
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [[self sections] objectAtIndex:index];
}

- (BTITableSectionInfo *)sectionInfoForIdentifier:(NSString *)identifier
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    if (identifier == nil)
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Nil identifier", self, __PRETTY_FUNCTION__);
        return nil;
    }
    
    BTITableSectionInfo *sectionInfoToReturn = nil;
    
    for (BTITableSectionInfo *sectionInfo in [self sections])
    {
        if ([[sectionInfo identifier] isEqualToString:identifier])
        {
            sectionInfoToReturn = sectionInfo;
            break;
        }
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return sectionInfoToReturn;
}

- (id)representedObjectAtSectionIndex:(NSInteger)index
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    BTITableSectionInfo *sectionInfo = [self sectionInfoAtIndex:index];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [sectionInfo representedObject];
}

- (BTITableRowInfo *)rowInfoAtIndexPath:(NSIndexPath *)indexPath
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    BTITableSectionInfo *sectionInfo = [self sectionInfoAtIndex:[indexPath section]];
    BTITableRowInfo *rowInfo = [sectionInfo objectInRowsAtIndex:[indexPath row]];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return rowInfo;
}

- (BTITableRowInfo *)rowInfoForIdentifier:(NSString *)identifier
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    if (identifier == nil)
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Nil identifier", self, __PRETTY_FUNCTION__);
        return nil;
    }
    
    BTITableRowInfo *rowInfoToReturn = nil;
    
    for (BTITableSectionInfo *sectionInfo in [self sections])
    {
        for (BTITableRowInfo *rowInfo in [sectionInfo enumeratorOfRows])
        {
            if ([[rowInfo identifier] isEqualToString:identifier])
            {
                rowInfoToReturn = rowInfo;
                break;
            }
        }
        
        if (rowInfoToReturn != nil)
        {
            break;
        }
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return rowInfoToReturn;
}

- (id)representedObjectAtIndexPath:(NSIndexPath *)indexPath
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    BTITableRowInfo *rowInfo = [self rowInfoAtIndexPath:indexPath];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [rowInfo representedObject];
}

#pragma mark - Interrogation Methods

- (NSInteger)indexOfSectionInfo:(BTITableSectionInfo *)sectionInfo
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [[self sections] indexOfObject:sectionInfo];
}

- (NSInteger)indexOfRepresentedSectionObject:(id)representedObject
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSInteger returnIndex = NSNotFound;
    
    NSInteger index = -1;
    
    for (BTITableSectionInfo *sectionInfo in [self sections])
    {
        index++;
        if ([representedObject isEqual:[sectionInfo representedObject]])
        {
            returnIndex = index;
            break;
        }
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return returnIndex;
}

- (NSInteger)indexOfSectionIdentifier:(NSString *)identifier
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSInteger returnIndex = NSNotFound;
    
    NSInteger index = -1;
    
    for (BTITableSectionInfo *sectionInfo in [self sections])
    {
        index++;
        if ([identifier isEqual:[sectionInfo identifier]])
        {
            returnIndex = index;
            break;
        }
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return returnIndex;
}

- (NSIndexPath *)indexPathOfRowInfo:(BTITableRowInfo *)rowInfo
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSUInteger section = 0;
    NSUInteger row = NSNotFound;
    
    for (BTITableSectionInfo *sectionInfo in [self sectionInfos])
    {
        row = [sectionInfo indexOfRowsObject:rowInfo];
        
        if (row != NSNotFound)
        {
            break;
        }
        
        section++;
    }
    
    NSIndexPath *indexPath = nil;
    
    if (row != NSNotFound)
    {
        indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return indexPath;
}

- (NSIndexPath *)indexPathOfRepresentedRowObject:(id)representedObject
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSUInteger section = 0;
    NSUInteger row = NSNotFound;
    
    for (BTITableSectionInfo *sectionInfo in [self sectionInfos])
    {
        row = [sectionInfo indexOfRepresentedObject:representedObject];
        
        if (row != NSNotFound)
        {
            break;
        }
        
        section++;
    }
    
    NSIndexPath *indexPath = nil;
    
    if (row != NSNotFound)
    {
        indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return indexPath;
}

- (NSIndexPath *)indexPathOfRowIdentifier:(NSString *)identifier
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSUInteger section = 0;
    NSUInteger row = NSNotFound;
    
    for (BTITableSectionInfo *sectionInfo in [self sectionInfos])
    {
        row = [sectionInfo indexOfIdentifier:identifier];
        
        if (row != NSNotFound)
        {
            break;
        }
        
        section++;
    }
    
    NSIndexPath *indexPath = nil;
    
    if (row != NSNotFound)
    {
        indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return indexPath;
}

- (NSIndexSet *)allSectionIndexes
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [[self sections] count])];
}

- (NSArray *)allIndexPaths
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSMutableArray *indexPaths = [NSMutableArray array];
       
    for (NSInteger section = 0; section < [[self sectionInfos] count]; section++)
    {
        BTITableSectionInfo *sectionInfo = [self sectionInfoAtIndex:section];
        
        for (NSInteger row = 0; row < [sectionInfo countOfRows]; row++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
            [indexPaths addObject:indexPath];
        }
    }

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [NSArray arrayWithArray:indexPaths];
}

#pragma mark - NSFastEnumeration Methods

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)enumerationState
                                  objects:(id __unsafe_unretained [])buffer
                                    count:(NSUInteger)len
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [[self sections] countByEnumeratingWithState:enumerationState
                                                objects:buffer
                                                  count:len];
}


@end
