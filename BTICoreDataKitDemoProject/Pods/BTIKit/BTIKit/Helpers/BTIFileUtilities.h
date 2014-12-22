//
//  BTIFileUtilities.h
//  BTIKit
//  v1.2
//
//  Created by Brian Slick in August 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

// Libraries
@import Foundation;

// Classes and Forward Declarations

// Public Constants

// Protocols

@interface BTIFileUtilities : NSObject

// Public Properties

// Public Methods

// Directories
+ (NSURL *)documentsDirectoryURL;
+ (NSURL *)libraryDirectoryURL;
+ (NSURL *)cacheDirectoryURL;
+ (NSURL *)libraryApplicationSupportDirectoryURL;

@end
