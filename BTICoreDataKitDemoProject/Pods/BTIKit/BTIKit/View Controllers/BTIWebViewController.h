//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.4
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

/*
 
 OVERVIEW
 
 A simple class for UIWebView purposes that sets up some typical boilerplate code. Intended to be further subclassed. Since the UIWebViewDelegate methods automatically show indicator activity in this class, it is recommend to call super if overriding these methods.
 
 */

// Libraries

// Forward Declarations and Classes
#import "BTIViewController.h"

// Public Constants

// Protocols

@interface BTIWebViewController : BTIViewController <UIWebViewDelegate>

#pragma mark - IBOutlet Properties

/// Returns the web view managed by this class. If it has not been supplied via IB or viewDidLoad, one will be created in viewWillAppear:
@property (nonatomic, strong) IBOutlet UIWebView *webView;

#pragma mark - Other Public Properties

/// The first url to be loaded by the web view. If present, will be automatically loaded in viewWillAppear:
@property (nonatomic, copy) NSURL *url;

/// Nil by default. It will need to be manually populated. If present, it will be animated by the web view delegate methods at appropriate times.
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;

#pragma mark - Public Methods

/**
 Loads the provided url in the web view.
 
 @param url the NSURL to load
 */
- (void)loadURL:(NSURL *)url;

@end
