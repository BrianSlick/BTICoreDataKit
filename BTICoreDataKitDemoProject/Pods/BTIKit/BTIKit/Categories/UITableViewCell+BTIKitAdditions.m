//
//  UITableViewCell+BTIKitAdditions.m
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "UITableViewCell+BTIKitAdditions.h"

// Models and other global
#import "BTIMacros.h"

@implementation UITableViewCell (BTIKitAdditions)

- (UITableView *)enclosingTableViewBTI
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    UITableView *tableView = nil;
    UIView *view = self;
    while (view != nil)
    {
        if ([view isKindOfClass:[UITableView class]])
        {
            tableView = (UITableView *)view;
            break;
        }
        view = [view superview];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return tableView;
}

+ (id)cellFromNibNameBTI:(NSString *)nibNameOrNil
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (nibNameOrNil == nil)
    {
        nibNameOrNil = NSStringFromClass([self class]);
    }
    
    NSArray *nibContents = [[NSBundle bundleForClass:[self class]] loadNibNamed:nibNameOrNil owner:nil options:nil];

    id cellToReturn = nil;
    
    for (id nibItem in nibContents)
    {
        if ([nibItem isKindOfClass:[self class]])
        {
            cellToReturn = nibItem;
            break;
        }
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return cellToReturn;
}

+ (instancetype)cellFromNibBTI;
{
    return [[self class] cellFromNibNameBTI:NSStringFromClass([self class])];
}

@end
