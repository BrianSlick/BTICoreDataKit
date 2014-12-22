//
//  UITableViewHeaderFooterView+BTIKitAdditions.h
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in August 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

// Libraries
@import UIKit;

@interface UITableViewHeaderFooterView (BTIKitAdditions)

/**
 Returns a view loaded from a nib with the provided name
 
 @param nibNameOrNil The name of the nib file to load. The nib file name should not contain any leading path information. If you specify nil, will look for a nib with a matching class name.
 
 @return A UITableViewHeaderFooterView (or subclass) object, or nil.
 */
+ (id)headerFooterViewFromNibNameBTI:(NSString *)nibNameOrNil;

/**
 Returns a view loaded from a nib with name matching the class name.
 
 @return A UITableViewHeaderFooterView (or subclass) object, or nil.
 */
+ (instancetype)headerFooterViewFromNibBTI;

@end
