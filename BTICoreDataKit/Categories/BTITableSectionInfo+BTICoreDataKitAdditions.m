//
//  BTICoreDataKit -- [https://github.com/BriTerIdeas/BTICoreDataKit]
//  v1.2
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "BTITableSectionInfo+BTICoreDataKitAdditions.h"

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
