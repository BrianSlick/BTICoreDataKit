//
//  BTITableContentsManager.h
//  BTIKit
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

/*
 
 OVERVIEW
 
 The spirit of this class is to be a non-Core Data equivalent of a NSFetchedResultsController.  Currently the primary benefit of this class is to simplify UITableViewDataSource and UITableViewDelegate methods, in a similar way that NSFRC does, providing objectAtIndePath: style methods.
 
 This class utilizes the companion classes BTITableSectionInfo and BTITableRowInfo.  BTITableSectionInfo is analogous to NSFetchedResultsSectionInfo, and BTITableRowInfo is analogous to NSTreeNode (OS X).  The intention is to populate the 'sections' array with section info objects, which are in turn populated with row info objects.  Once populated, this class provides utility methods for retrieving information for handy use with table views.
 
 This class has not yet reached the goal of emulating NSFRC.  There is currently no means of providing a pool of objects or a sort descriptor that then automatically sorts the pool of objects.  And there is no delegate, so changes to the table view still have to be handled manually.  These are wishlist capabilities for future development.
 
 */

// Libraries

// Classes and Forward Declarations
#import "BTIObject.h"
@class BTITableSectionInfo;
@class BTITableRowInfo;

// Public Constants

// Protocols

@interface BTITableContentsManager : BTIObject <NSFastEnumeration>

#pragma mark - Properties

/// An array of BTITableSectionInfo objects
@property (nonatomic, readonly) NSArray *sections;

/// Default value is 44.0. Value will be used in concert with heightForRowAtIndexPath:
@property (nonatomic, assign) CGFloat minimumRowHeight;

#pragma mark - Primary Management Methods

/**
 Empties the sections array.  BTITableSectionInfo and BTITableRowInfo objects are moved to a cache.
 */
- (void)reset;

#pragma mark - BTITableSectionInfo Methods

/**
 Requests a BTITableSectionInfo object from the local cache, creating one if necessary.  This object is NOT added to the sections array.
 
 @return A BTITableSectionInfo object that is NOT managed by the receiver.
 */
- (BTITableSectionInfo *)dequeueReusableSectionInfo;

/**
 Requests a BTITableSectionInfo object from the local cache, creating one if necessary.  This object is added to the sections array.
 
 @return A BTITableSectionInfo object that has been added to the receiver's contents.
 */
- (BTITableSectionInfo *)dequeueReusableSectionInfoAndAddToContents;

/**
 Adds a BTITableSectionInfo to the sections array.
 
 @param sectionInfo A BTITableSectionInfo object to add to the receiver's contents.
 */
- (void)addSectionInfo:(BTITableSectionInfo *)sectionInfo;

#pragma mark - BTITableRowInfoMethods

/**
 Requests a BTITableRowInfo object from the local cache, creating one if necessary.  This object is NOT added to any sections.
 
 @return A BTITableRowInfo object that is NOT managed by the receiver.
 */
- (BTITableRowInfo *)dequeueReusableRowInfo;

/**
 Adds a BTITableRowInfo object to a BTITableSectionInfo object.  If makeNewSelection is NO, the row info will be added to the last section info in the array.  If no section infos are already in the array, a new one will be added, and this row info will be added to it.  If makeNewSelection is YES, a new section info object will be added to the array, and this row info will be added to it.
 
 @param rowInfo The row info object to be added
 @param isNewSection YES to create a new section when adding the row info. NO to add to the last section.
 */
- (void)addRowInfo:(BTITableRowInfo *)rowInfo makeNewSection:(BOOL)isNewSection;    

#pragma mark - UITableView Support Methods

/**
 Returns the number of sections.
 
 @return The number of sections.
 */
- (NSUInteger)numberOfSections;

/**
 Returns the 'headerTitle' value of the BTITableSectionInfo object at the specified index
 
 @param section Index for the section
 
 @return The header title for the section info at \em section
 */
- (NSString *)headerTitleInSection:(NSInteger)section;

/**
 Returns the 'footerTitle' value of the BTITableSectionInfo object at the specified index
 
 @param section Index for the section
 
 @return The footer title for the section info at \em section

 */
- (NSString *)footerTitleInSection:(NSInteger)section;

/**
 Returns the number of rows in the section at the specified index
 
 @param section Index for the section
 
 @return The number of rows in the section at \em section.
 */
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

/**
 Returns the height to use for a row in a specified location
 
 @param indexPath Index path for the row
 
 @return The height of the row at \em indexPath
 */
- (CGFloat)heightForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 Returns an array of all section index titles. Intended for use with sectionIndexTitlesForTableView:
 
 @return An array of NSString objects.
 */
- (NSArray *)sectionIndexTitles;

#pragma mark - Content Retrieval Methods

/**
 Returns the BTITableSectionInfo object at the specified index
 
 @param index Index for the section
 
 @return The BTITableSectionInfo object at \em index.
 */
- (BTITableSectionInfo *)sectionInfoAtIndex:(NSInteger)index;

/**
 Returns the BTITableSectionInfo's represented object at the specified index
 
 @param index Index for the section
 
 @return The BTITableSectionInfo's represented object at \em index.
 */
- (id)representedObjectAtSectionIndex:(NSInteger)index;

/**
 Returns the BTITableRowInfo object at the specified index path
 
 @param indexPath Index path for the row info
 
 @return The BTITableRowInfo object at \em indexPath
 */
- (BTITableRowInfo *)rowInfoAtIndexPath:(NSIndexPath *)indexPath;

/**
 Returns the BTITableRowInfo's represented object at the specified index
 
 @param indexPath Index path for the row info
 
 @return The BTITableRowInfo's represented object at \em indexPath
 */
- (id)representedObjectAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - Interrogation Methods

/**
 Returns the index of the section info object
 
 @param sectionInfo A BTITableSectionInfo object to locate
 
 @return The index of \em sectionInfo
 */
- (NSInteger)indexOfSectionInfo:(BTITableSectionInfo *)sectionInfo;

/**
 Returns the index of the section info's represented object
 
 @param representedObject A section represented object to locate
 
 @return The index of \em representedObject
 */
- (NSInteger)indexOfRepresentedSectionObject:(id)representedObject;

/**
 Returns the index of the section info object's identifier
 
 @param identifier A section identifier to locate
 
 @return The index of \em identifier
 */
- (NSInteger)indexOfSectionIdentifier:(NSString *)identifier;

/**
 Returns the index path of the row info object
 
 @param rowInfo A BTITableRowInfo object to locate
 
 @return The index path of \em rowInfo
 */
- (NSIndexPath *)indexPathOfRowInfo:(BTITableRowInfo *)rowInfo;

/**
 Returns the index path of the row info object's represented object
 
 @param representedObject A row represented object to locate
 
 @return The indexPath of \em representedObject
 */
- (NSIndexPath *)indexPathOfRepresentedRowObject:(id)representedObject;

/**
 Returns the index path of the row info object's identifier
 
 @param identifier A row identifier to locate
 
 @return The index path of \em identifier
 */
- (NSIndexPath *)indexPathOfRowIdentifier:(NSString *)identifier;

/**
 Returns an index set describing all section indexes.  This can be used before and after any content changes to help determine what changed.
 
 @return An index set for all sections
 */
- (NSIndexSet *)allSectionIndexes;

/**
 Returns an array containing all row index paths.  This can be used before and after any content changes to help determine what changed.
 
 @return An array containing NSIndexPath objects for each row in each section
 */
- (NSArray *)allIndexPaths;

@end
