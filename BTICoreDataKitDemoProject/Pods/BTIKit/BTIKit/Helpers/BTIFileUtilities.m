//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "BTIFileUtilities.h"

// Libraries

// Other Global

// Categories
#import "NSFileManager+BTIKitAdditions.h"

// Models

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

+ (nullable NSURL *)documentsDirectoryURL
{
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                           inDomains:NSUserDomainMask];
    
    return [urls firstObject];
}

+ (nullable NSURL *)libraryDirectoryURL
{
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory
                                                           inDomains:NSUserDomainMask];
    
    return [urls firstObject];
}

+ (nullable NSURL *)cacheDirectoryURL
{
    NSArray *urls = [[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory
                                                           inDomains:NSUserDomainMask];
    
    return [urls firstObject];
}

+ (nullable NSURL *)libraryApplicationSupportDirectoryURL
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
