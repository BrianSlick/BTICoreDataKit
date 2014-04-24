//
//  BTITableViewCell.m
//  BTIKit
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//
//  reuseIdentifier concept from http://iphonedevelopment.blogspot.com/2010/04/table-view-cells-redux.html

#import "BTITableViewCell.h"

// Models and other global
#import "BTIKit.h"

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

@end
