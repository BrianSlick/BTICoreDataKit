//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
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

- (nullable UICollectionView *)enclosingCollectionViewBTI
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

+ (nullable instancetype)cellFromNibNameBTI:(nullable NSString *)nibNameOrNil
{
    return [[self class] viewFromNibNameBTI:nibNameOrNil];
}

+ (nullable instancetype)cellFromNibBTI
{
    return [[self class] cellFromNibNameBTI:NSStringFromClass([self class])];
}

@end
