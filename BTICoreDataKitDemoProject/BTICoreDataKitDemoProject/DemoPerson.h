//
//  DemoPerson.h
//  BTICoreDataKitDemoProject
//
//  Created by Brian Slick on 4/23/14.
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DemoPerson : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;

@end
