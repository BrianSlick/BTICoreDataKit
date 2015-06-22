//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "UICollectionViewCell+BTIKitAdditions.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories
#import "UIView+BTIKitAdditions.h"

// Models

// Private Constants

@implementation UICollectionViewCell (BTIKitAdditions)

- (UICollectionView *)enclosingCollectionViewBTI
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    UICollectionView *collectionView = nil;
    UIView *view = self;
    while (view != nil)
    {
        if ([view isKindOfClass:[UICollectionView class]])
        {
            collectionView = (UICollectionView *)view;
            break;
        }
        view = [view superview];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return collectionView;
}

+ (instancetype)cellFromNibNameBTI:(NSString *)nibNameOrNil
{
    return [[self class] viewFromNibNameBTI:nibNameOrNil];
}

+ (instancetype)cellFromNibBTI
{
    return [[self class] cellFromNibNameBTI:NSStringFromClass([self class])];
}

@end
