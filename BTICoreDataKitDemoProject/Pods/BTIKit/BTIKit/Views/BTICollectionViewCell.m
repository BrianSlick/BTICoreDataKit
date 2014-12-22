//
//  BTICollectionViewCell.m
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in August 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "BTICollectionViewCell.h"

// Models and other global
#import "BTIMacros.h"

// Private Constants

@interface BTICollectionViewCell ()

// Private Properties

@end

@implementation BTICollectionViewCell

#pragma mark - Dealloc and Memory Management


#pragma mark - Custom Getters and Setters


#pragma mark - Initialization and UI Creation Methods


#pragma mark - UICollectionViewCell Overrides

- (NSString *)reuseIdentifier
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [[self class] reuseIdentifierBTI];
}

#pragma mark - Misc Methods

+ (NSString *)reuseIdentifierBTI
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return NSStringFromClass([self class]);
}

+ (void)registerNibForCollectionViewBTI:(UICollectionView *)collectionView
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSString *className = NSStringFromClass([self class]);
    
    UINib *cellNib = [UINib nibWithNibName:className bundle:nil];
    [collectionView registerNib:cellNib forCellWithReuseIdentifier:className];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

+ (instancetype)dequeueCellFromCollectionViewBTI:(UICollectionView *)collectionView
                                    forIndexPath:(NSIndexPath *)indexPath
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [collectionView dequeueReusableCellWithReuseIdentifier:[[self class] reuseIdentifierBTI] forIndexPath:indexPath];
}

@end
