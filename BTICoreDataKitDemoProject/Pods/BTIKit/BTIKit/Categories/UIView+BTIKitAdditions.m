//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "UIView+BTIKitAdditions.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// Private Constants

@implementation UIView (BTIKitAdditions)

+ (instancetype)viewFromNibNameBTI:(NSString *)nibNameOrNil
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (nibNameOrNil == nil)
    {
        nibNameOrNil = NSStringFromClass([self class]);
    }
    
    NSArray *nibContents = [[NSBundle bundleForClass:[self class]] loadNibNamed:nibNameOrNil owner:nil options:nil];
    
    id viewToReturn = nil;
    
    for (id nibItem in nibContents)
    {
        if ([nibItem isKindOfClass:[self class]])
        {
            viewToReturn = nibItem;
            break;
        }
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return viewToReturn;
}

+ (instancetype)viewFromNibBTI;
{
    return [[self class] viewFromNibNameBTI:NSStringFromClass([self class])];
}

@end
