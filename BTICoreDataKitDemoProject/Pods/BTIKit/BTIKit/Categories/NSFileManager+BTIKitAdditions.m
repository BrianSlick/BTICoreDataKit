//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "NSFileManager+BTIKitAdditions.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// Private Constants

@implementation NSFileManager (BTIKitAdditions)

- (nullable NSArray<NSString *> *)contentsOfDirectoryAtPathBTI:(nullable NSString *)path
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (path == nil)
    {
        NSLog(@"BTI ERROR: Attempted to obtain contents of nil path");
        return nil;
    }
    
    NSError *error = nil;
    NSArray *contents = [self contentsOfDirectoryAtPath:path error:&error];
    if (contents == nil)
    {
        NSLog(@"BTI ERROR: Contents of directory at path:\n%@\n", [error localizedDescription]);
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return contents;
}

- (nullable NSArray *)contentsOfDirectoryAtURLBTI:(nullable NSURL *)url
                       includingPropertiesForKeys:(nullable NSArray<NSURLResourceKey> *)keys
                                          options:(NSDirectoryEnumerationOptions)mask
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (url == nil)
    {
        NSLog(@"BTI ERROR: Attempted to obtain contents of nil URL");
        return nil;
    }
    
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

- (BOOL)createDirectoryAtPathBTI:(nullable NSString *)path
     withIntermediateDirectories:(BOOL)createIntermediates
                      attributes:(nullable NSDictionary<NSString *, id> *)attributes
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (path == nil)
    {
        NSLog(@"BTI ERROR: Attempted to create directory at nil path");
        return nil;
    }
    
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

- (BOOL)createDirectoryAtURLBTI:(nullable NSURL *)url
    withIntermediateDirectories:(BOOL)createIntermediates
                     attributes:(nullable NSDictionary<NSString *, id> *)attributes
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (url == nil)
    {
        NSLog(@"BTI ERROR: Attempted to create directory at nil URL");
        return nil;
    }
    
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

- (BOOL)fileExistsAtFileURLBTI:(nullable NSURL *)url
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (url == nil)
    {
        return NO;
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return [self fileExistsAtPath:[url path]];
}

- (BOOL)removeItemAtPathBTI:(nullable NSString *)path
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (path == nil)
    {
        NSLog(@"BTI ERROR: Attempted to remove item at nil path");
        return NO;
    }
    
    NSError *error = nil;
    BOOL isRemoveSuccessful = [self removeItemAtPath:path error:&error];
    if (!isRemoveSuccessful)
    {
        NSLog(@"BTI ERROR: Remove Item at path:\n%@\n", [error localizedDescription]);
    }
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
    return isRemoveSuccessful;
}

- (BOOL)setAttributesBTI:(nullable NSDictionary<NSFileAttributeKey, id> *)attributes
            ofItemAtPath:(nullable NSString *)path
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (path == nil)
    {
        NSLog(@"BTI ERROR: Attempted to set attributes for item at nil path");
        return NO;
    }
    
    if (attributes == nil)
    {
        NSLog(@"BTI ERROR: Attempted to set nil attributes for item at path");
        return NO;
    }
    
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
               itemAtURL:(nullable NSURL *)url
          destinationURL:(nullable NSURL *)destinationURL
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (url == nil)
    {
        NSLog(@"BTI ERROR: Attempted to set ubiquitous for item at nil source URL");
        return NO;
    }
    
    if (destinationURL == nil)
    {
        NSLog(@"BTI ERROR: Attempted to set ubiquitous for item at nil destination URL");
        return NO;
    }
    
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

- (nullable NSURL *)URLForDirectoryBTI:(NSSearchPathDirectory)directory
                              inDomain:(NSSearchPathDomainMask)domain
                     appropriateForURL:(nullable NSURL *)url
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
