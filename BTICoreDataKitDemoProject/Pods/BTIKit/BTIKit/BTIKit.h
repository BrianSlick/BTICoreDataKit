//
//  BTIKit.h
//  v1.0.0
//
//  Created by Brian Slick in March 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

#pragma mark - Constants

// Master NSLog killer. Doesn't do anything unless explicitly defined in Build Settings.

// http://clingingtoideas.blogspot.com/2009/08/it-nslog-nslog.html
#ifdef BTI_KILL_NSLOG_OUTPUT
#define NSLog(format, ...)
#else
#define NSLog(format, ...) NSLog(format, ## __VA_ARGS__)
#endif

// Tracking log killer. Tracking logs are disabled by default, must be specifically requested in Build Settings.

#ifndef BTI_TRACKING_ENABLED
#define BTITrackingLog(...)
#else
#define BTITrackingLog NSLog
#endif

#pragma mark - Models

#import "BTIObject.h"
#import "BTINotificationInfo.h"
#import "BTITableRowInfo.h"
#import "BTITableSectionInfo.h"
#import "BTITableContentsManager.h"

#pragma mark - Views

#import "BTITableViewCell.h"

#pragma mark - Categories

#import "NSFileManager+BTIAdditions.h"
#import "NSMutableArray+BTIAdditions.h"
#import "NSNotificationCenter+BTIAdditions.h"
#import "NSString+BTIAdditions.h"
#import "UIDevice+BTIAdditions.h"
#import "UITableView+BTIAdditions.h"

#pragma mark - View Controllers

#import "BTIViewController.h"
#import "BTITableViewController.h"
#import "BTIArrayTableViewController.h"
#import "BTIManagerTableViewController.h"

