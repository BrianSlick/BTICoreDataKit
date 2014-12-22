//
//  NSMutableArray+BTIKitAdditions.h
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

// Libraries
@import Foundation;

@interface NSMutableArray (BTIKitAdditions)

/**
 Removes the first object in the array. Safe to use in the event the array is empty.
 */
- (void)removeFirstObjectBTI;

/**
 Moves an object in the array from/to the specified indexes.
 
 @param fromIndex Index of the item to move.
 @param toIndex Destination index for the item.
 */
- (void)moveObjectAtIndexBTI:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

/**
 Adds the provided string to the receiver. If the string is nil or blank, or if the object is not a string, it will not be added. This method is intended to be a companion to componentsJoinedByString:, allowing an array to be quickly populated with strings while removing a lot of validity checking boilerplate.

 @param string String object to be added to the array
 */
- (void)safelyAddPopulatedStringBTI:(NSString *)string;
 
@end
