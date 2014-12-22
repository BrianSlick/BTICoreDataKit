//
//  UITableView+BTIKitAdditions.h
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "UITableView+BTIKitAdditions.h"

// Models and other global
#import "BTIMacros.h"

@implementation UITableView (BTIKitAdditions)

- (NSIndexPath *)indexPathForRowContainingViewBTI:(UIView *)view
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    CGPoint correctedPoint = [view convertPoint:[view bounds].origin toView:self];

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [self indexPathForRowAtPoint:correctedPoint];
}

@end
