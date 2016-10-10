//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "NSString+BTIKitAdditions.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// Private Constants

@implementation NSString (BTIKitAdditions)

- (BOOL)writeToURLBTI:(nullable NSURL *)url
           atomically:(BOOL)useAuxiliaryFile
             encoding:(NSStringEncoding)enc
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (url == nil)
    {
        NSLog(@"BTI ERROR: Attempted to write to nil URL");
        return NO;
    }
    
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

- (BOOL)isNotEmptyBTI
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if ([self length] == 0)
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - No length", self, __PRETTY_FUNCTION__);
        return NO;
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return YES;
}

// http://www.cocoanetics.com/2014/06/e-mail-validation/
- (BOOL)isValidEmailAddressBTI
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if ([self length] == 0)
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Empty String", self, __PRETTY_FUNCTION__);
        return NO;
    }
    
    NSRange entireRange = NSMakeRange(0, [self length]);
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeLink
                                                               error:NULL];
    NSArray *matches = [detector matchesInString:self options:0 range:entireRange];
    
    // should only a single match
    if ([matches count] != 1)
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Invalid number of matches", self, __PRETTY_FUNCTION__);
        return NO;
    }
    
    NSTextCheckingResult *result = [matches firstObject];
    
    // result should be a link
    if (result.resultType != NSTextCheckingTypeLink)
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Non-link result", self, __PRETTY_FUNCTION__);
        return NO;
    }
    
    // result should be a recognized mail address
    if (![result.URL.scheme isEqualToString:@"mailto"])
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Not a mailto address", self, __PRETTY_FUNCTION__);
        return NO;
    }
    
    // match must be entire string
    if (!NSEqualRanges(result.range, entireRange))
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - Invalid range", self, __PRETTY_FUNCTION__);
        return NO;
    }
    
    // but schould not have the mail URL scheme
    if ([self hasPrefix:@"mailto:"])
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - mailto: prefix", self, __PRETTY_FUNCTION__);
        return NO;
    }
    
    // no complaints, string is valid email address
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return YES;
}

@end
