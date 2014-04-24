//
//  NSString+BTIAdditions.h
//  BTIKit
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import <Foundation/Foundation.h>

@interface NSString (BTIAdditions)

/** Passes directly through to writeToURL:atomically:encoding:error:
 */
- (BOOL)writeToURLBTI:(NSURL *)url atomically:(BOOL)useAuxiliaryFile encoding:(NSStringEncoding)enc;

@end
