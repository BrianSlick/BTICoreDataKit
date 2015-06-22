//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

// Libraries
@import Foundation;

@interface NSFileManager (BTIKitAdditions)

/** Passes directly through to contentsOfDirectoryAtPath:error:
 */
- (NSArray *)contentsOfDirectoryAtPathBTI:(NSString *)path;

/** Passes directly through to contentsOfDirectoryAtURL:includingPropertiesForKeys:options:error:
 */
- (NSArray *)contentsOfDirectoryAtURLBTI:(NSURL *)url includingPropertiesForKeys:(NSArray *)keys options:(NSDirectoryEnumerationOptions)mask;

/** Passes directly through to createDirectoryAtPath:withIntermediateDirectories:attributes:error:
 */
- (BOOL)createDirectoryAtPathBTI:(NSString *)path withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary *)attributes;

/** Passes directly through to createDirectoryAtURL:withIntermediateDirectories:attributes:error:
 */
- (BOOL)createDirectoryAtURLBTI:(NSURL *)url withIntermediateDirectories:(BOOL)createIntermediates attributes:(NSDictionary *)attributes;

/** Takes the path value of the provided url and passes it along to fileExistsAtPath:
 */
- (BOOL)fileExistsAtFileURLBTI:(NSURL *)url;

/** Passes directly through to removeItemAtPath:error:
 */
- (BOOL)removeItemAtPathBTI:(NSString *)path;

/** Passes directly through to setAttributes:ofItemAtPath:error:
 */
- (BOOL)setAttributesBTI:(NSDictionary *)attributes ofItemAtPath:(NSString *)path;

/** Passes directly through to setUbiquitous:itemAtURL:destinationURL:error:
 */
- (BOOL)setUbiquitousBTI:(BOOL)flag itemAtURL:(NSURL *)url destinationURL:(NSURL *)destinationURL;

/** Passes directly through to URLForDirectory:inDomain:appropriateForURL:create:error:
 */
- (NSURL *)URLForDirectoryBTI:(NSSearchPathDirectory)directory inDomain:(NSSearchPathDomainMask)domain appropriateForURL:(NSURL *)url create:(BOOL)shouldCreate;

@end
