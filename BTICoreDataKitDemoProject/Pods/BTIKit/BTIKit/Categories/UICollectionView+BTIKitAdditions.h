//
//  UICollectionView+BTIKitAdditions.h
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in August 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

// Libraries
@import UIKit;

@interface UICollectionView (BTIKitAdditions)

/**
 Provides the index path for the row that contains a particular cell subview.
 
 @param view A view that should be somewhere in the collection view's hierarchy, such as a cell subview.
 
 @return An index path representing the row and section associated with \em view or nil.
 */
- (NSIndexPath *)indexPathForItemContainingViewBTI:(UIView *)view;

@end
