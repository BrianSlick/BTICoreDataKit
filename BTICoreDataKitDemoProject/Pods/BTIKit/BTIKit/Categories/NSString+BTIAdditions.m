//
//  NSString+BTIAdditions.m
//  BTIKit
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "NSString+BTIAdditions.h"

@implementation NSString (BTIAdditions)

- (BOOL)writeToURLBTI:(NSURL *)url
           atomically:(BOOL)useAuxiliaryFile
             encoding:(NSStringEncoding)enc
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSError *error = nil;
    BOOL isWriteSuccessful = [self writeToURL:url
                                   atomically:useAuxiliaryFile
                                     encoding:enc
                                        error:&error];
    if (!isWriteSuccessful)
    {
        NSLog(@"BTI ERROR: Write to URL: %@", [error localizedDescription]);
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return isWriteSuccessful;
}

@end
