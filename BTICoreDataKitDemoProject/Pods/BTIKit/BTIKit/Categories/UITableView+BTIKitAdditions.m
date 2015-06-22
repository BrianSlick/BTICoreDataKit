//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "UITableView+BTIKitAdditions.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// Private Constants

@implementation UITableView (BTIKitAdditions)

- (NSIndexPath *)indexPathForRowContainingViewBTI:(UIView *)view
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    CGPoint correctedPoint = [view convertPoint:[view bounds].origin toView:self];

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [self indexPathForRowAtPoint:correctedPoint];
}

@end
