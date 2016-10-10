//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "UITableViewHeaderFooterView+BTIKitAdditions.h"

// Libraries

// Other Global

// Categories
#import "UIView+BTIKitAdditions.h"

// Models

// Private Constants

@implementation UITableViewHeaderFooterView (BTIKitAdditions)

+ (nullable instancetype)headerFooterViewFromNibNameBTI:(nullable NSString *)nibNameOrNil
{
    return [[self class] viewFromNibNameBTI:nibNameOrNil];
}

+ (nullable instancetype)headerFooterViewFromNibBTI
{
    return [[self class] headerFooterViewFromNibNameBTI:NSStringFromClass([self class])];
}

@end
