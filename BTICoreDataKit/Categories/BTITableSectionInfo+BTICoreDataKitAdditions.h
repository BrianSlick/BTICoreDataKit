//
//  BTICoreDataKit -- [https://github.com/BriTerIdeas/BTICoreDataKit]
//  v1.3
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 This category allows BTITableSectionInfo to conform to the NSFetchedResultsSectionInfo protocol.
 Refer to documentation for NSFetchedResultsSectionInfo for additional information.
 
 */

// Libraries
@import CoreData;

// Classes and Forward Declarations
#import "BTITableSectionInfo.h"

// Public Constants

// Protocols

@interface BTITableSectionInfo (BTICoreDataKitAdditions) <NSFetchedResultsSectionInfo>

@property (nonatomic, readonly) NSUInteger numberOfObjects;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *indexTitle;

@end
