//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "UIDevice+BTIKitAdditions.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// Private Constants

@implementation UIDevice (BTIKitAdditions)

+ (BOOL)isIpadBTI
{
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad);
}

+ (BOOL)isIphoneBTI
{
    return ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone);
}

// http://blog.mugunthkumar.com/coding/iphone-tutorial-better-way-to-check-capabilities-of-ios-devices/
+ (BOOL)isRetinaBTI
{
    BOOL isRetina = NO;

    CGFloat scale = 1.0;

    UIScreen *screen = [UIScreen mainScreen];

    if ([screen respondsToSelector:@selector(scale)])
    {
        scale = [screen scale];
    }

    if (scale >= 2.0)
    {
        isRetina = YES;
    }

    return isRetina;
}

@end
