//
//  BTIKit -- [https://github.com/BriTerIdeas/BTIKit]
//  v1.6
//
//  Created by Brian Slick. Copyright (c) 2015 BriTer Ideas LLC. All rights reserved.
//

// Inspired by WWDC 2015 sample code from Advanced Operations session. Earthquakes.

/*
 
 OVERVIEW
 
 UIAlertView never cared if another UIAlertView was already showing. You'd show the alert - didn't even have to be from a view controller - and that's all you had to do. If a situation occurred such that another UIAlertView already was showing, the newest alert would be shown. Upon its dismissal, the previous alert would then be shown, repeating backwards in time until all alerts have been dismissed. In this case, the very last one viewed would be the very first one that was shown.
 
 I'm not saying this is a great user experience. But, at least the user DID see every alert that came along (even if some context may have become confusing in the meantime). And at least the developer didn't have to worry about managing alerts app-wide.
 
 Well, our cushy lifestyle is over; UIAlertView has been deprecated, replaced with UIAlertController. In general, UIAlertController is a far superior widget. But there is one key design decision that has the potential to make developer life rough in some situations. Instead of inheriting from UIView, UIAlertController - as the name suggests - inherits from UIViewController. And that change affects how the view is shown to the user. Instead of a simple view being added to the hierarchy, it is now a view controller that is presented modally. That's just fine, until you need to show another one, and get a warning along these lines:
 
 Warning: Attempt to present <UIAlertController: 0x7f886ac86b40> on <SampleTableViewController: 0x7f886ac4bbf0> which is already presenting (null)
 
 Ok, no big deal, it's just a warning. Well, it actually is a big deal, because the second alert never shows. So this means that across your entire app, you have to guard against the possibility that an alert is already showing. That blows.
 
 In an effort to solve this problem, I found a reference to the WWDC 2015 video titled Advanced Operations. There is a sample project with this presentation called Earthquakes. One of the techniques shown is to use NSOperation and NSOperationQueue to make sure that only one alert is attempted at a time, and that subsequent alerts will wait until previous alerts are finished. The sample is written in Swift, which I don't want to support in this library yet, and also goes far and above what my immediate need is. So this combination of classes - BTIAlertOperation and BTIAlertManager - are my attempt to acheive the same result in Objective-C. Using these does maintain the old behavior of sequential alerts being shown progressively as the user dismisses them. One change from the UIAlertView behavior is that alerts are shown in order, so the very last one viewed will be the very last one that was shown, which is opposite of the old behavior. I think it makes more sense this way, so will not be attempting to perfectly reproduce the old behavior.
 
 */

// Libraries
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// Classes and Forward Declarations

// Public Constants

// Protocols

@interface BTIAlertOperation : NSOperation

// Public Properties

/// Text that will be shown in the alert's title field.
@property (nullable, nonatomic, copy) NSString *title;

/// Text that will be shown in the alert's message field.
@property (nullable, nonatomic, copy) NSString *message;

// Public Methods

/**
 Creates and returns a new BTIAlertOperation object
 
 @param presentationContext The presenting view controller for the alert. If \em nil is provided, the application's main window root controller will be used
 */
- (nonnull instancetype)initWithPresentationContext:(nullable UIViewController *)presentationContext;

/**
 Adds a button to the alert. All parameters are passed straight through to UIAlertAction
 
 @param title The text to use for the button title.
 @param style Additional styling information to apply to the button
 @param handler A block to execute when the user selects the action
 */
- (void)addActionWithTitle:(nullable NSString *)title
                     style:(UIAlertActionStyle)style
                   handler:(void (^ __nullable)(UIAlertAction * _Nullable action))handler;


@end
