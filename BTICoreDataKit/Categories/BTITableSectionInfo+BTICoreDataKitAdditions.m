//
//  BTITableSectionInfo+BTICoreDataKitAdditions.m
//  BTICoreDataKitDemoProject
//
//  Created by Brian Slick on 5/2/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTICoreDataKit
//

#import "BTITableSectionInfo+BTICoreDataKitAdditions.h"

#import "BTICoreDataKit.h"

@implementation BTITableSectionInfo (BTICoreDataKitAdditions)

- (NSUInteger)numberOfObjects
{
    return [self countOfRows];
}

- (NSString *)name
{
    return [self headerTitle];
}

- (NSString *)indexTitle
{
    return [self sectionIndexTitle];
}

@end
