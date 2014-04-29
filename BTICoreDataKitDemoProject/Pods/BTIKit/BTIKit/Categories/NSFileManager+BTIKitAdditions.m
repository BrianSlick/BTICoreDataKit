//
//  NSFileManager+BTIKitAdditions.m
//  BTIKit
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "NSFileManager+BTIKitAdditions.h"

@implementation NSFileManager (BTIKitAdditions)

- (NSArray *)contentsOfDirectoryAtPathBTI:(NSString *)path
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSError *error = nil;
    NSArray *contents = [self contentsOfDirectoryAtPath:path error:&error];
    if (contents == nil)
    {
        NSLog(@"BTI ERROR: Contents of directory at path:\n%@\n", [error localizedDescription]);
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return contents;
}

- (NSArray *)contentsOfDirectoryAtURLBTI:(NSURL *)url
              includingPropertiesForKeys:(NSArray *)keys
                                 options:(NSDirectoryEnumerationOptions)mask
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSError *error = nil;
    NSArray *contents = [self contentsOfDirectoryAtURL:url
                            includingPropertiesForKeys:keys
                                               options:mask
                                                 error:&error];
    if (contents == nil)
    {
        NSLog(@"BTI ERROR: Contents of directory at URL:\n%@\n", [error localizedDescription]);
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return contents;
}

- (BOOL)createDirectoryAtPathBTI:(NSString *)path
     withIntermediateDirectories:(BOOL)createIntermediates
                      attributes:(NSDictionary *)attributes
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSError *error = nil;
    BOOL isCreateSuccessful = [self createDirectoryAtPath:path
                              withIntermediateDirectories:YES
                                               attributes:nil
                                                    error:&error];
    if (!isCreateSuccessful)
    {
        NSLog(@"BTI ERROR: Create directory at path:\n%@\n", [error localizedDescription]);
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return isCreateSuccessful;
}

- (BOOL)createDirectoryAtURLBTI:(NSURL *)url
    withIntermediateDirectories:(BOOL)createIntermediates
                     attributes:(NSDictionary *)attributes
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSError *error = nil;
    BOOL isCreateSuccessful = [self createDirectoryAtURL:url
                             withIntermediateDirectories:createIntermediates
                                              attributes:attributes
                                                   error:&error];
    if (!isCreateSuccessful)
    {
        NSLog(@"BTI ERROR: Create directory at URL:\n%@\n", [error localizedDescription]);
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return isCreateSuccessful;
}

- (BOOL)removeItemAtPathBTI:(NSString *)path
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSError *error = nil;
    BOOL isRemoveSuccessful = [self removeItemAtPath:path error:&error];
    if (!isRemoveSuccessful)
    {
        NSLog(@"BTI ERROR: Remove Item at path:\n%@\n", [error localizedDescription]);
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return isRemoveSuccessful;
}

- (BOOL)setAttributesBTI:(NSDictionary *)attributes
            ofItemAtPath:(NSString *)path
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSError *error = nil;
    BOOL isAttributeSuccessful = [self setAttributes:attributes
                                        ofItemAtPath:path
                                               error:&error];
    if (!isAttributeSuccessful)
    {
        NSLog(@"BTI ERROR: Set file attributes:\n%@\n", [error localizedDescription]);
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return isAttributeSuccessful;
}

- (BOOL)setUbiquitousBTI:(BOOL)flag
               itemAtURL:(NSURL *)url
          destinationURL:(NSURL *)destinationURL
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSError *error = nil;
    BOOL isUbiquitousSuccessful = [self setUbiquitous:flag
                                            itemAtURL:url
                                       destinationURL:destinationURL
                                                error:&error];
    if (!isUbiquitousSuccessful)
    {
        NSLog(@"BTI ERROR: Set Ubiquitous:\n%@\n", [error localizedDescription]);
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return isUbiquitousSuccessful;
}

- (NSURL *)URLForDirectoryBTI:(NSSearchPathDirectory)directory
                     inDomain:(NSSearchPathDomainMask)domain
            appropriateForURL:(NSURL *)url
                       create:(BOOL)shouldCreate
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    NSError *error = nil;
    NSURL *returnUrl = [self URLForDirectory:directory
                                    inDomain:domain
                           appropriateForURL:url
                                      create:shouldCreate
                                       error:&error];
    if (returnUrl == nil)
    {
        NSLog(@"BTI ERROR: URL for Directory:\n%@\n", [error localizedDescription]);
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return returnUrl;
}

@end
