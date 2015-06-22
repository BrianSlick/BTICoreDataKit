//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "BTITableViewCell.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

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

// From http://iphonedevelopment.blogspot.com/2010/04/table-view-cells-redux.html
- (NSString *)reuseIdentifier
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [[self class] reuseIdentifierBTI];
}

#pragma mark - Misc Methods

// From http://iphonedevelopment.blogspot.com/2010/04/table-view-cells-redux.html
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
