//
//  BTIMacros.h
//  v1.2
//
//  Created by Brian Slick in December 2014
//  Copyright (c) 2014 BriTer Ideas LLC. All rights reserved.
//  https://github.com/BriTerIdeas/BTIKit
//

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
