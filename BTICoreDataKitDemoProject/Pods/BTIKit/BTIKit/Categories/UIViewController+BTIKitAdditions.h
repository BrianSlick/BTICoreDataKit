//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

// Libraries
#import <UIKit/UIKit.h>

@interface UIViewController (BTIKitAdditions)

/**
 Creates a UIBarButtonItem with the provided title and sets it as the back button item
 
 @param title The title that should appear in the back button
 */
- (void)setBackBarButtonTitleBTI:(nullable NSString *)title;

@end
