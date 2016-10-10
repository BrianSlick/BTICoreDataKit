//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

// Libraries
#import <Foundation/Foundation.h>

@interface NSFileManager (BTIKitAdditions)

/** Passes directly through to contentsOfDirectoryAtPath:error:
 */
- (nullable NSArray<NSString *> *)contentsOfDirectoryAtPathBTI:(nullable NSString *)path;

/** Passes directly through to contentsOfDirectoryAtURL:includingPropertiesForKeys:options:error:
 */
- (nullable NSArray *)contentsOfDirectoryAtURLBTI:(nullable NSURL *)url includingPropertiesForKeys:(nullable NSArray<NSURLResourceKey> *)keys options:(NSDirectoryEnumerationOptions)mask;

/** Passes directly through to createDirectoryAtPath:withIntermediateDirectories:attributes:error:
 */
- (BOOL)createDirectoryAtPathBTI:(nullable NSString *)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(nullable NSDictionary<NSString *, id> *)attributes;

/** Passes directly through to createDirectoryAtURL:withIntermediateDirectories:attributes:error:
 */
- (BOOL)createDirectoryAtURLBTI:(nullable NSURL *)url withIntermediateDirectories:(BOOL)createIntermediates attributes:(nullable NSDictionary<NSString *, id> *)attributes;

/** Takes the path value of the provided url and passes it along to fileExistsAtPath:
 */
- (BOOL)fileExistsAtFileURLBTI:(nullable NSURL *)url;

/** Passes directly through to removeItemAtPath:error:
 */
- (BOOL)removeItemAtPathBTI:(nullable NSString *)path;

/** Passes directly through to setAttributes:ofItemAtPath:error:
 */
- (BOOL)setAttributesBTI:(nullable NSDictionary<NSFileAttributeKey, id> *)attributes ofItemAtPath:(nullable NSString *)path;

/** Passes directly through to setUbiquitous:itemAtURL:destinationURL:error:
 */
- (BOOL)setUbiquitousBTI:(BOOL)flag itemAtURL:(nullable NSURL *)url destinationURL:(nullable NSURL *)destinationURL;

/** Passes directly through to URLForDirectory:inDomain:appropriateForURL:create:error:
 */
- (nullable NSURL *)URLForDirectoryBTI:(NSSearchPathDirectory)directory inDomain:(NSSearchPathDomainMask)domain appropriateForURL:(nullable NSURL *)url create:(BOOL)shouldCreate;

@end
