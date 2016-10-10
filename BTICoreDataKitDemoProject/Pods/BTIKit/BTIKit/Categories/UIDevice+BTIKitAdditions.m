//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "UIDevice+BTIKitAdditions.h"

// Libraries

// Other Global

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

@end
