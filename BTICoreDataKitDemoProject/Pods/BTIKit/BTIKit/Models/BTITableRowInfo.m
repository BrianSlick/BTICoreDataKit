//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "BTITableRowInfo.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// Private Constants

@interface BTITableRowInfo ()

// Private Properties
@property (nonnull, nonatomic, copy) NSString *UUIDString;

@end

@implementation BTITableRowInfo

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Management


#pragma mark - Custom Getters and Setters


#pragma mark - Initialization

- (id)init
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    self = [super init];
    if (self)
    {
        [self setUUIDString:[[NSUUID UUID] UUIDString]];
        [self setCellAccessoryType:UITableViewCellAccessoryNone];
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return self;
}

#pragma mark - NSObject Methods

- (NSUInteger)hash
{
    return [[self UUIDString] hash];
}

- (BOOL)isEqual:(id)anObject
{
    BOOL isEqual = NO;
    
    if ([anObject isKindOfClass:[self class]])
    {
        isEqual = ([[(BTITableRowInfo *)anObject UUIDString] isEqualToString:[self UUIDString]]);
    }
    
    return isEqual;
}

#pragma mark - Misc Methods

- (void)reset
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [self setIdentifier:nil];

    [self setRepresentedObject:nil];
    
    [self setParentSectionInfo:nil];
    
    [self setText:nil];
    [self setDetailText:nil];
    [self setCellAccessoryType:UITableViewCellAccessoryNone];
    [self setRowHeight:0.0];
    
    [self setImage:nil];
    [self setImageName:nil];
    [self setImageFileURL:nil];
    
    [self setRowSelectionBlock:nil];
    [self setRowAccessorySelectionBlock:nil];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)populateCell:(nullable UITableViewCell *)cell
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    if (cell == nil)
    {
        return;
    }
    
    [[cell textLabel] setText:[self text]];
    [[cell detailTextLabel] setText:[self detailText]];
    [cell setAccessoryType:[self cellAccessoryType]];
    
    UIImage *image = nil;
    
    if ([self image] != nil)
    {
        image = [self image];
    }
    else if ([self imageName] != nil)
    {
        image = [UIImage imageNamed:[self imageName]];
    }
    else if ([self imageFileURL] != nil)
    {
        image = [UIImage imageWithContentsOfFile:[[self imageFileURL] path]];
    }
    
    [[cell imageView] setImage:image];

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)safelyPerformRowSelectionBlock
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    if ([self rowSelectionBlock] != nil)
    {
        [self rowSelectionBlock]();
    }

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)safelyPerformRowAccessorySelectionBlock
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);

    if ([self rowAccessorySelectionBlock] != nil)
    {
        [self rowAccessorySelectionBlock]();
    }

    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

@end
