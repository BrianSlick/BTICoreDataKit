//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

// Libraries
@import UIKit;


@interface UITableView (BTIKitAdditions)


//  Taken from http://pragprog.com/titles/cdirec/ios-recipes
//  iOS Recipes: Tips and Tricks for Awesome iPhone and iPad Apps
//  by Paul Warren and Matt Drance
/**
 Provides the index path for the row that contains a particular cell subview.
 
 @param view A view that should be somewhere in the table view's hierarchy, such as a cell subview.
 
 @return An index path representing the row and section associated with \em view or nil.
 */
- (NSIndexPath *)indexPathForRowContainingViewBTI:(UIView *)view;

@end
