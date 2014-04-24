//
//  BTITableSectionInfo.m
//  BTIKit
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "BTITableSectionInfo.h"

#import "BTIKit.h"

// Models and other global

// Private Constants

@interface BTITableSectionInfo ()

// Private Properties
@property (nonatomic, copy) NSString *UUIDString;

@property (nonatomic, strong) NSMutableArray *rows;

@end

@implementation BTITableSectionInfo

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Management


#pragma mark - Custom Getters and Setters

- (NSMutableArray *)rows
{
    if (_rows == nil)
    {
        _rows = [[NSMutableArray alloc] init];
    }
    return _rows;
}

#pragma mark - Initialization

- (id)init
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    self = [super init];
    if (self)
    {
        [self setUUIDString:[[NSUUID UUID] UUIDString]];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return self;
}

#pragma mark - NSObject Methods

- (NSUInteger)hash
{
    return [[self UUIDString] hash];
}

- (BOOL)isEqual:(id)anObject
{
    BOOL isEqual = NO;
    
    if ([anObject isKindOfClass:[self class]])
    {
        isEqual = ([[(BTITableSectionInfo *)anObject UUIDString] isEqualToString:[self UUIDString]]);
    }
    
    return isEqual;
}

#pragma mark - Misc Methods

- (void)reset
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [self setIdentifier:nil];
    
    [self setRepresentedObject:nil];

    [self removeAllRowsObjects];

    [self setHeaderTitle:nil];
    [self setFooterTitle:nil];
    [self setSectionIndexTitle:nil];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Rows Accessor Methods

- (NSArray *)objects
{
    return [NSArray arrayWithArray:[self rows]];
}

- (NSUInteger)countOfRows
{
    return [[self rows] count];
}

- (id)objectInRowsAtIndex:(NSUInteger)index
{
    return [[self rows] objectAtIndex:index];
}

- (void)addRowsObject:(id)anObject
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (anObject == nil)
    {
        //BTITrackingLog(@"<<< Leaving %s >>> EARLY - No Object", __PRETTY_FUNCTION__);
        return;
    }
    
    [[self rows] addObject:anObject];
    
    if ([anObject isKindOfClass:[BTITableRowInfo class]])
    {
        [(BTITableRowInfo *)anObject setParentSectionInfo:self];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)addRowsObjectsFromArray:(NSArray *)array
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    for (id object in array)
    {
        [self addRowsObject:object];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)addRowsObjectsFromSet:(NSSet *)set
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [self addRowsObjectsFromArray:[set allObjects]];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)removeRowsObject:(id)anObject
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [[self rows] removeObject:anObject];
    
    if ([anObject isKindOfClass:[BTITableRowInfo class]])
    {
        [(BTITableRowInfo *)anObject setParentSectionInfo:nil];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)removeObjectFromRowsAtIndex:(NSUInteger)index
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    id anObject = [[self rows] objectAtIndex:index];
    
    [self removeRowsObject:anObject];

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)removeAllRowsObjects
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSSet *objectsToRemove = [NSSet setWithArray:[self rows]];
    
    for (id anObject in objectsToRemove)
    {
        [self removeRowsObject:anObject];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)insertObject:(id)anObject
       inRowsAtIndex:(NSUInteger)index
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [[self rows] insertObject:anObject atIndex:index];
    
    if ([anObject isKindOfClass:[BTITableRowInfo class]])
    {
        [(BTITableRowInfo *)anObject setParentSectionInfo:self];
    }

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (NSUInteger)indexOfRowsObject:(id)anObject
{
    return [[self rows] indexOfObject:anObject];
}

- (NSEnumerator *)enumeratorOfRows
{
    return [[self rows] objectEnumerator];
}

- (void)sortRowsUsingDescriptors:(NSArray *)sortDescriptors
{
    [[self rows] sortUsingDescriptors:sortDescriptors];
}

#pragma mark - BTITableRowInfo/BTITableContentsManager Support Methods

- (NSUInteger)indexOfIdentifier:(NSString *)identifier
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    if (identifier == nil)
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Identifier not provided", self, __PRETTY_FUNCTION__);
        return NSNotFound;
    }
    
    if (![self containsRowInfos])
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Contents are not BTITableRowInfo objects", self, __PRETTY_FUNCTION__);
        return NSNotFound;
    }
    
    NSUInteger indexToReturn = NSNotFound;
    NSUInteger index = 0;
    
    for (BTITableRowInfo *rowInfo in [self rows])
    {
        if ([[rowInfo identifier] isEqualToString:identifier])
        {
            indexToReturn = index;
            break;
        }
        index++;
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return indexToReturn;
}

- (NSUInteger)indexOfRepresentedObject:(id)representedObject
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    if (representedObject == nil)
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Represented object not provided", self, __PRETTY_FUNCTION__);
        return NSNotFound;
    }
    
    if (![self containsRowInfos])
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Contents are not BTITableRowInfo objects", self, __PRETTY_FUNCTION__);
        return NSNotFound;
    }
    
    NSUInteger indexToReturn = NSNotFound;
    NSUInteger index = 0;
    
    for (BTITableRowInfo *rowInfo in [self rows])
    {
        if ([[rowInfo representedObject] isEqual:representedObject])
        {
            indexToReturn = index;
            break;
        }
        index++;
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return indexToReturn;
}

#pragma mark - Misc Methods

- (BOOL)containsRowInfos
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    id anObject = [[self rows] firstObject];
    
    BOOL isRowInfo = [anObject isKindOfClass:[BTITableRowInfo class]];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return isRowInfo;
}

#pragma mark - NSFastEnumeration Methods

- (NSUInteger) countByEnumeratingWithState:(NSFastEnumerationState *)enumerationState
                                   objects:(id __unsafe_unretained [])buffer
                                     count:(NSUInteger)len
{
    return [[self rows] countByEnumeratingWithState:enumerationState
                                                   objects:buffer
                                                     count:len];
}

@end
