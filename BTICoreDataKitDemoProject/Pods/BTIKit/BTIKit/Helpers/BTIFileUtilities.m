//
//  BTIFileUtilities.m
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in August 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#import "BTIFileUtilities.h"

// Models and other global
#import "NSFileManager+BTIKitAdditions.h"

// Private Constants

@interface BTIFileUtilities ()

// Private Properties

@end

@implementation BTIFileUtilities

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Management


#pragma mark - Custom Getters and Setters


#pragma mark - Initialization


#pragma mark - Directories

+ (NSURL *)documentsDirectoryURL
{
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                           inDomains:NSUserDomainMask];
    
    return [urls firstObject];
}

+ (NSURL *)libraryDirectoryURL
{
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory
                                                           inDomains:NSUserDomainMask];
    
    return [urls firstObject];
}

+ (NSURL *)cacheDirectoryURL
{
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory
                                                           inDomains:NSUserDomainMask];
    
    return [urls firstObject];
}

+ (NSURL *)libraryApplicationSupportDirectoryURL
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSApplicationSupportDirectory
                                                           inDomains:NSUserDomainMask];
    
    NSURL *urlToReturn = [urls firstObject];
    
    if ( (urlToReturn != nil) && (![fileManager fileExistsAtPath:[urlToReturn path]]) )
    {
        [fileManager createDirectoryAtURLBTI:urlToReturn
                 withIntermediateDirectories:YES
                                  attributes:nil];
    }
    
    return urlToReturn;
}

@end
