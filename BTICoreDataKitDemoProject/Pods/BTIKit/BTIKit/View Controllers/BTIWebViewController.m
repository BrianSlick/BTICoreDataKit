//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

#import "BTIWebViewController.h"

// Libraries

// Other Global
#import "BTIMacros.h"

// Categories

// Models

// View Controllers

// Views

// Private Constants

@interface BTIWebViewController ()

// Private Properties

@end

@implementation BTIWebViewController

#pragma mark - Synthesized Properties


#pragma mark - Dealloc and Memory Methods

- (void)dealloc
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    // Clear delegates and other global references
    [_webView setDelegate:nil];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - Initialization and UI Creation Methods


#pragma mark - Custom Getters and Setters

- (void)viewWillAppear:(BOOL)animated
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [super viewWillAppear:animated];
    
    UIWebView *webView = [self webView];
    if (webView == nil)
    {
        UIView *mainView = [self view];
        
        webView = [[UIWebView alloc] initWithFrame:[mainView bounds]];
        [webView setAutoresizingMask:[mainView autoresizingMask]];
        
        [mainView addSubview:webView];
        
        [webView setDelegate:self];
        [self setWebView:nil];
    }
    
    [self loadURL:[self url]];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)viewWillDisappear:(BOOL)animated
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [super viewWillDisappear:animated];
    
    [[self webView] stopLoading];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - BTIViewController Overrides


#pragma mark - Notification Handlers


#pragma mark - UI Response Methods


#pragma mark - Misc Methods

- (void)loadURL:(nullable NSURL *)url
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    if (url == nil)
    {
        //BTITrackingLog(@"<<< Leaving  <%p> %s >>> EARLY - No URL", self, __PRETTY_FUNCTION__);
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [[self webView] loadRequest:request];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

#pragma mark - UIWebViewDelegate Methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [[self activityIndicatorView] startAnimating];
    [[self activityIndicatorView] setHidden:NO];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [[self activityIndicatorView] stopAnimating];
    [[self activityIndicatorView] setHidden:YES];
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}

- (void)webView:(UIWebView *)webView
didFailLoadWithError:(NSError *)error
{
    //BTITrackingLog(@">>> Entering <%p> %s <<<", self, __PRETTY_FUNCTION__);
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [[self activityIndicatorView] stopAnimating];
    [[self activityIndicatorView] setHidden:YES];
    
    NSLog(@"webView:DidFailLoadWithError: %@", error);
    
    //BTITrackingLog(@"<<< Leaving  <%p> %s >>>", self, __PRETTY_FUNCTION__);
}


@end
