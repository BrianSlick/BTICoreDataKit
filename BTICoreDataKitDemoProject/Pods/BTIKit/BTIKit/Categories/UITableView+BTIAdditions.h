//
//  UITableView+BTIAdditions.h
//  BTIKit
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import <Foundation/Foundation.h>


@interface UITableView (BTIAdditions)


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
