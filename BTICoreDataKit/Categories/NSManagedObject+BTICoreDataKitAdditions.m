//
//  NSManagedObject+BTICoreDataKitAdditions.m
//  BTICoreDataKit
//
//  Created by Brian Slick in April 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTICoreDataKit
//

#import "NSManagedObject+BTICoreDataKitAdditions.h"

#import "BTICoreDataKit.h"

@implementation NSManagedObject (BTICoreDataKitAdditions)

+ (NSEntityDescription *)entityDescriptionInContextBTI:(NSManagedObjectContext *)context
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return [NSEntityDescription entityForName:NSStringFromClass([self class]) inManagedObjectContext:context];
}

+ (instancetype)newManagedObjectInContextBTI:(NSManagedObjectContext *)context
{
	//BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
	NSEntityDescription *entity = [[self class] entityDescriptionInContextBTI:context];
    
	//BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
	return [[[self class] alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
}

@end
