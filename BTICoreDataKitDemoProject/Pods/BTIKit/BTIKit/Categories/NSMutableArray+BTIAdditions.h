//
//  NSMutableArray+BTIAdditions.h
//  BTIKit
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (BTIAdditions)

/**
 Removes the first object in the array.
 */
- (void)removeFirstObjectBTI;

/**
 Moves an object in the array from/to the specified indexes.
 
 @param fromIndex Index of the item to move.
 @param toIndex Destination index for the item.
 */
- (void)moveObjectAtIndexBTI:(NSUInteger)fromIndex toIndex:(NSUInteger)toIndex;

@end
