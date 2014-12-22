//
//  UICollectionViewCell+BTIKitAdditions.m
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in August 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "UICollectionViewCell+BTIKitAdditions.h"

// Models and other global
#import "BTIMacros.h"

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

+ (instancetype)cellFromNibBTI
{
    return [[self class] cellFromNibNameBTI:NSStringFromClass([self class])];
}

@end
