//
//  UITableViewHeaderFooterView+BTIKitAdditions.m
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in August 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "UITableViewHeaderFooterView+BTIKitAdditions.h"

// Models and other global
#import "BTIMacros.h"

@implementation UITableViewHeaderFooterView (BTIKitAdditions)

+ (id)headerFooterViewFromNibNameBTI:(NSString *)nibNameOrNil
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (nibNameOrNil == nil)
    {
        nibNameOrNil = NSStringFromClass([self class]);
    }
    
    NSArray *nibContents = [[NSBundle bundleForClass:[self class]] loadNibNamed:nibNameOrNil owner:nil options:nil];
    
    id headerFooterViewToReturn = nil;
    
    for (id nibItem in nibContents)
    {
        if ([nibItem isKindOfClass:[self class]])
        {
            headerFooterViewToReturn = nibItem;
            break;
        }
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return headerFooterViewToReturn;
}

+ (instancetype)headerFooterViewFromNibBTI
{
    return [[self class] headerFooterViewFromNibNameBTI:NSStringFromClass([self class])];
}

@end
