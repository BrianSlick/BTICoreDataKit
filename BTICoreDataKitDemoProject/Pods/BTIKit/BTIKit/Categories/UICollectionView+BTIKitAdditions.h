//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

// Libraries
#import <UIKit/UIKit.h>

@interface UICollectionView (BTIKitAdditions)

/**
 Provides the index path for the row that contains a particular cell subview.
 
 @param view A view that should be somewhere in the collection view's hierarchy, such as a cell subview.
 
 @return An index path representing the row and section associated with \em view or nil.
 */
- (nullable NSIndexPath *)indexPathForItemContainingViewBTI:(nullable UIView *)view;

@end
