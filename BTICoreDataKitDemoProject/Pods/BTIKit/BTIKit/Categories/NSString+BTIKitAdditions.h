//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

// Libraries
@import Foundation;

@interface NSString (BTIKitAdditions)

/** Passes directly through to writeToURL:atomically:encoding:error:
 */
- (BOOL)writeToURLBTI:(NSURL *)url atomically:(BOOL)useAuxiliaryFile encoding:(NSStringEncoding)enc;

/**
 Returns whether the receiver is empty
 
 @return YES if the receiver has contents, otherwise NO.
 */
- (BOOL)isNotEmptyBTI;

/**
 Returns whether the receiver is a valid email address
 
 @return YES if the receiver has is a valid email address, otherwise NO.
 */
- (BOOL)isValidEmailAddressBTI;


@end
