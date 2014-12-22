//
//  BTITableViewCell.m
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//
//  reuseIdentifier concept from http://iphonedevelopment.blogspot.com/2010/04/table-view-cells-redux.html

#import "BTITableViewCell.h"

// Models and other global
#import "BTIMacros.h"

// Private Constants

@interface BTITableViewCell ()

// Private Properties

@end

@implementation BTITableViewCell

#pragma mark - Dealloc and Memory Management


#pragma mark - Custom Getters and Setters


#pragma mark - Initialization and UI Creation Methods

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    self = [super initWithStyle:style
                reuseIdentifier:[[self class] reuseIdentifierBTI]];
    if (self)
    {
        // Initialization code
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return self;
}

#pragma mark - UITableViewCell Overrides

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
    [tableView registerNib:cellNib forCellReuseIdentifier:className];

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

+ (instancetype)dequeueCellFromTableViewBTI:(UITableView *)tableView
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [tableView dequeueReusableCellWithIdentifier:[[self class] reuseIdentifierBTI]];
}

@end
