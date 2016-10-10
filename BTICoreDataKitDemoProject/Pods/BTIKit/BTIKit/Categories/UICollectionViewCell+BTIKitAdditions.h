//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

// Libraries
#import <UIKit/UIKit.h>

@interface UICollectionViewCell (BTIKitAdditions)

/**
 Returns the nearest ancestor UICollectionView object containing the receiver. Inspired by the NSView method enclosingScrollView.
 
 @return A UICollectionView object, or nil
 */
- (nullable UICollectionView *)enclosingCollectionViewBTI;

/**
 Returns a cell loaded from a nib with the provided name
 
 @param nibNameOrNil The name of the nib file to load. The nib file name should not contain any leading path information. If you specify nil, will look for a nib with a matching class name.
 
 @return A UICollectionViewCell (or subclass) object, or nil.
 */
+ (nullable instancetype)cellFromNibNameBTI:(nullable NSString *)nibNameOrNil;

/**
 Returns a cell loaded from a nib with name matching the class name.
 
 @return A UICollectionViewCell (or subclass) object, or nil.
 */
+ (nullable instancetype)cellFromNibBTI;

@end
