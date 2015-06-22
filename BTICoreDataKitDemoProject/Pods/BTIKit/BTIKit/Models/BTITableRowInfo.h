//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 The intention of this class is to reduce the amount of if/else, if/else statements that often go along with manually-driven table views.  Some if/else statements in cellForRow, more if/else statements in didSelectRow, maybe even more for setting a section header, etc.  Instead of spreading all of that information out across numerous methods, this class can be used to encapsulate a considerable amount of definition in one spot.  A single BTITableRowInfo object can contain textLabel and detailTextLabel contents, image details, accessory definitions, as well as blocks for handling row selection or row accessory selection.  Basically most of the UITableViewCell properties that might be interesting.
 
 This class can be used standalone, but it draws inspiration from NSTreeNode and provides a representedObject property allowing it to be used with any other model objects.
 
 */

// Libraries
@import UIKit;

// Classes and Forward Declarations
#import "BTIObject.h"
@class BTITableSectionInfo;

// Public Constants
typedef void(^BTIRowSelectionBlock)(void);

// Protocols

@interface BTITableRowInfo : BTIObject

#pragma mark - Properties

/// A string value that can be used to enable special-case customization beyond what this class otherwise provides.
@property (nonatomic, copy) NSString *identifier;

/// The object that the row info represents. Concept from NSTreeNode.
@property (nonatomic, strong) id representedObject;

/// The parent table section info, if present.
@property (nonatomic, weak) BTITableSectionInfo *parentSectionInfo;

#pragma mark - Table Cell Display Properties

/// Corresponds to UITableViewCell textLabel property.
@property (nonatomic, copy) NSString *text;

/// Corresponds to UITableViewCell detailTextLabel property.
@property (nonatomic, copy) NSString *detailText;

/// Corresponds to UITableViewCell accessoryType property.
@property (nonatomic, assign) UITableViewCellAccessoryType cellAccessoryType;

/// Row height, to be used with tableView:heightForRowAtIndexPath:
@property (nonatomic, assign) CGFloat rowHeight;

// Only one of the following properties needs to be supplied in order for an image to be placed in a cell using the populateCell: method.
// The checking order will be: 1) image, 2) imageName, 3) imageFileURL

/// Image object to be supplied to cell's imageView
@property (nonatomic, strong) UIImage *image;

/// Image name for cell's imageView, to be loaded with +imageNamed:
@property (nonatomic, copy) NSString *imageName;

/// URL to image for cell's imageView
@property (nonatomic, copy) NSURL *imageFileURL;

#pragma mark - Table Cell Action Properties

/// Block to be executed upon row tap
@property (nonatomic, copy) BTIRowSelectionBlock rowSelectionBlock;

/// Block to be executed upon row accessory tap
@property (nonatomic, copy) BTIRowSelectionBlock rowAccessorySelectionBlock;

#pragma mark - Misc Methods

/**
 Clears all properties. There probably isn't much of a reason to call this manually. It can/will be called when used with BTITableContentsManager.
 */
- (void)reset;

/**
 Populates the provided cell using the properties of this class. Intended to be used in tableView:cellForRowAtIndexPath:.  This method should be called before any special-case cell formatting.
 */
- (void)populateCell:(UITableViewCell *)cell;

/**
 Executes the rowSelectionBlock. Safe to call even if there is no block.
 */
- (void)safelyPerformRowSelectionBlock;

/**
 Executes the rowAccessorySelectionBlock. Safe to call even if there is no block.
 */
- (void)safelyPerformRowAccessorySelectionBlock;

@end
