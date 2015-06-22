//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "UITableViewHeaderFooterView+BTIKitAdditions.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories
#import "UIView+BTIKitAdditions.h"

// Models

// Private Constants

@implementation UITableViewHeaderFooterView (BTIKitAdditions)

+ (instancetype)headerFooterViewFromNibNameBTI:(NSString *)nibNameOrNil
{
    return [[self class] viewFromNibNameBTI:nibNameOrNil];
}

+ (instancetype)headerFooterViewFromNibBTI
{
    return [[self class] headerFooterViewFromNibNameBTI:NSStringFromClass([self class])];
}

@end
