//
//  UIDevice+BTIAdditions.m
//  BTIKit
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "UIDevice+BTIAdditions.h"

#import "BTIKit.h"

@implementation UIDevice (BTIAdditions)

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
