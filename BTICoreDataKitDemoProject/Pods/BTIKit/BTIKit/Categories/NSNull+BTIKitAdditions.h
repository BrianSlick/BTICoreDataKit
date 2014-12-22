//
//  NSNull+BTIKitAdditions.h
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in August 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

// Libraries
@import Foundation;

@interface NSNull (BTIKitAdditions)

/**
 Returns whether the receiver is empty
 
 @return YES if the receiver has contents, otherwise NO.
 */
- (BOOL)isNotEmptyBTI;

@end
