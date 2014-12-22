//
//  BTITableSectionInfo.h
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

/*
 
 OVERVIEW
 
 The intention of this class is to make multi-section manually-driven table views easier.  It is inspired by NSFetchedResultsSectionInfo.
 
 The goal is to encapsulate all useful information about a section - ex: header, footer - here in a single object, rather than having multiple if/else statements spread out across multiple delegate methods.  This information can instead be defined in one place, and referenced later as needed.
 
 This class supports fast enumeration, so you can do for (id object in tableSectionInfo) if you want.
 
 */

// Libraries

// Classes and Forward Declarations
#import "BTIObject.h"
@class BTITableRowInfo;

// Public Constants

// Protocols


@interface BTITableSectionInfo : BTIObject <NSFastEnumeration>

#pragma mark - Public Properties

/// A string value that can be used to enable special-case customization beyond what this class otherwise provides.
@property (nonatomic, copy) NSString *identifier;

/// The object that the section info represents. Concept from NSTreeNode.
@property (nonatomic, strong) id representedObject;

/// Section header. Should be used for tableView:titleForHeaderInSection:
@property (nonatomic, copy) NSString *headerTitle;

/// Section footer. Should be used for tableView:titleForFooterInSection:
@property (nonatomic, copy) NSString *footerTitle;

/// Section index (appears on right side of table views).  Should be used in sectionIndexTitlesForTableView:
@property (nonatomic, copy) NSString *sectionIndexTitle;

/// The array of objects in the section
@property (nonatomic, readonly) NSArray *objects;

#pragma mark - Misc Methods

/**
 Clears all properties. There probably isn't much of a reason to call this manually. It can/will be called when used with BTITableContentsManager.
 */
- (void)reset;

#pragma mark - Rows Accessor Methods

/**
 Returns the number of rows
 
 @return The number of rows
 */
- (NSUInteger)countOfRows;

/**
 Returns the object located at the specified index
 
 @param index An index within the bounds of the array
 
 @return The object located at \em index.
 */
- (id)objectInRowsAtIndex:(NSUInteger)index;

/**
 Inserts the given object at the end of the row contents
 
 @param anObject The object to add to the end of the rows contents.
 */
- (void)addRowsObject:(id)anObject;

/**
 Adds the objects contained in an array to the end of the row contents
 
 @param array An array of objects to add to the end of the row contents
 */
- (void)addRowsObjectsFromArray:(NSArray *)array;

/**
 Adds the objects contained in a set to the end of the row contents. As sets do not have order, this method should probably be followed up with sortRowsUsingDescriptors: in order to get reliable results.
 
 @param set A set of objects to add to the end of the row contents
 */
- (void)addRowsObjectsFromSet:(NSSet *)set;

/**
 Remove all occurrences in the row contents of a given object
 
 @param anObject The object to remove from the contents
 */
- (void)removeRowsObject:(id)anObject;

/**
 Removes the object at \em index
 
 @param index The index from which to remove the object in the row contents
 */
- (void)removeObjectFromRowsAtIndex:(NSUInteger)index;

/**
 Empties the row contents
 */
- (void)removeAllRowsObjects;

/** Inserts a given object into the row contents at a given index
 
 @param anObject The object to add to the row contents
 @param index The index in the row contents at which to insert \em anObject.
 */
- (void)insertObject:(id)anObject inRowsAtIndex:(NSUInteger)index;

/**
 Returns the lowest index whose corresponding row contents value is equal to a given object
 
 @param anObject An object
 
 @return Index of the object
 */
- (NSUInteger)indexOfRowsObject:(id)anObject;

/**
 Returns an enumerator object that lets you access each object in the row contents
 
 @return NSEnumerator object for the row contents
 */
- (NSEnumerator *)enumeratorOfRows;

/**
 Sorts the row contents using the given array of sort descriptors
 
 @param sortDescriptors An array containing the NSSortDescriptor objects to use to sort the row contents
 */
- (void)sortRowsUsingDescriptors:(NSArray *)sortDescriptors;

#pragma mark - BTITableRowInfo/BTITableContentsManager Support Methods

/**
 Returns the index of the row info's identifier. Returns NSNotFound if the contents are not BTITableRowInfo objects.
 
 @param identifier The BTITableRowInfo identifier
 
 @return Index of the identifier
 */
- (NSUInteger)indexOfIdentifier:(NSString *)identifier;

/**
 Returns the index of the row info's represented object. Returns NSNotFound if the contents are not BTITableRowInfo objects.
 
 @param representedObject The BTITableRowInfo represented object
 
 @return Index of the represented object
 */
- (NSUInteger)indexOfRepresentedObject:(id)representedObject;


@end
