//
//  BTITableSectionInfo+BTICoreDataKitAdditions.h
//  BTICoreDataKitDemoProject
//
//  Created by Brian Slick on 5/2/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTICoreDataKit
//

/*
 
 OVERVIEW
 
 This category allows BTITableSectionInfo to conform to the NSFetchedResultsSectionInfo protocol.
 Refer to documentation for NSFetchedResultsSectionInfo for additional information.
 
 */

@import CoreData;
#import "BTITableSectionInfo.h"

@interface BTITableSectionInfo (BTICoreDataKitAdditions) <NSFetchedResultsSectionInfo>

@property (nonatomic, readonly) NSUInteger numberOfObjects;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *indexTitle;

@end