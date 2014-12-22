//
//  BTITableViewHeaderFooterView.m
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in August 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "BTITableViewHeaderFooterView.h"

// Models and other global
#import "BTIMacros.h"

// Private Constants

@interface BTITableViewHeaderFooterView ()

// Private Properties

@end


@implementation BTITableViewHeaderFooterView

#pragma mark - Dealloc and Memory Management


#pragma mark - Custom Getters and Setters


#pragma mark - Initialization and UI Creation Methods

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    self = [super initWithReuseIdentifier:[[self class] reuseIdentifierBTI]];
    if (self)
    {
        // Initialization code
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return self;
}

#pragma mark - UITableViewHeaderFooterView Overrides

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

+ (void)registerNibForTableViewBTI:(UITableView *)tableView
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSString *className = NSStringFromClass([self class]);
    
    UINib *cellNib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:cellNib forHeaderFooterViewReuseIdentifier:className];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

+ (instancetype)dequeueHeaderFooterViewFromTableViewBTI:(UITableView *)tableView
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:[[self class] reuseIdentifierBTI]];
}

@end
