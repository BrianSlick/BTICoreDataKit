# BTIKit
by **Brian Slick**

Personal: [@BrianSlick](http://twitter.com/BrianSlick) | [Clinging To Ideas](http://clingingtoideas.blogspot.com)  
Business: [@BriTerIdeas](http://twitter.com/BriTerIdeas) | [briterideas.com](http://briterideas.com)

Newest version is: v1.4

### What is BTIKit?

**A collection of classes and categories intended to take some pain out of common activities.**

- A set of view controllers that encourage consistent behaviors, and handle what would otherwise be boilerplate code.
- A set of models that are used to support table and collection views.
- A miscellaneous set of categories to handle a variety of tasks.


### Yeah, Yeah, Seriously, What Is It?

In summary:

**Categories**

- NSArray: Random object at index.
- NSFileManager: Log those errors when you are otherwise too lazy to do so.
- NSMutableArray: Remove the first object, and move object to new different index.
- NSNotificationCenter: Make sure notifications are posted on the main thread.
- NSNull: isEmpty. isIncompleteLibraryWithoutNSNullCategory.
- NSString: Another error logging one. And isEmpty. And email validation.
- UICollectionView: IndexPath for a view.
- UICollectionViewCell: Enclosing collection view, nib loading.
- UIDevice: isIpad, isIphone, isRetina. Woo!
- UITableView: IndexPath for a view. Not my idea.
- UITableViewCell: Enclosing table view, nib loading.
- UITableViewHeaderFooterView: Nib loading.
- UIView. Nib loading.
- UIViewController: Back button title.

**Models**

- BTIObject: Mostly empty. Nice -description method, though.
- BTINotificationInfo: Simplify adding/removing notification observers.
- BTITableRowInfo: Encapsulate useful stuff for table rows.
- BTITableSectionInfo: Encapsulate useful stuff for table sections.
- BTITableContentsManager: Combine rowInfos and sectionInfos to manage your table view.

**Views**

- BTICollectionViewCell: reuseIdentifier. Nib registration. Dequeueing.
- BTITableViewCell: reuseIdentifier. Nib registration. Dequeueing.
- BTITableViewHeaderFooterView: reuseIdentifier. Nib registration. Dequeueing.

**View Controllers**

- BTIViewController: Mostly shows how to use the notification helpers. Parent class for all of the following...

...for Table Views
- BTITableViewController: Adds a table view.
- BTIArrayTableViewController: Adds a simple array to BTITableViewController.
- BTIManagerTableViewController: Uses a BTITableContentsManager with BTITableViewController.

...for Collection Views
- BTICollectionViewController: Adds a collection view.
- BTIArrayCollectionViewController: Adds a simple array to BTICollectionViewController.
- BTIManagerCollectionViewController: Uses a BTITableContentsManager with BTICollectionViewController.

...for Web Views
- BTIWebViewController. Adds a web view.


**Bonus**

- Nice demonstration of my awesome coding style.
- Demonstration of my caveman logs, too (I've thoughtfully commented them out for you).
- Sample app demonstrating the concepts
- Lots of unit tests

### Why did you create this?

I am a firm believer in being consistent with one's coding style. Previously I have tried to enforce this consistency through the use of templates. Templates have their place, but then you wind up with the same code copied everywhere the template was used. After far too long, I realized I could use superclasses instead. I'm not always the brightest bulb...

I have a particular interest in table views, which is why most of this code is really table view oriented. But there are a number of other little things included too. If anything here causes even one person to say "Oh, duh, I should have done something like that a long time ago" then I have served my purpose in making this code public.

### Getting the code

BTIKit can be cloned from its git repository on github. You can find the repository here: [http://github.com/BriTerIdeas/BTIKit](http://github.com/BriTerIdeas/BTIKit)

### Requirements and supported OS versions

- **iOS 6.0** or later (**with ARC**) for iPhone, iPad and iPod touch
- Older iOS versions can be supported by commenting out NSUUID objects in a couple of places. Most of this stuff can actually go back pretty far.

### License

The original code portions of BTIKit are distributed under The MIT License.

### Saying Thank You

If you find this code useful, then any of the following would really make me happy:

- Including some form of attribution would be great. Maybe something like this:
"Includes BTIKit code by Brian Slick, BriTer Ideas LLC"
...along with a link to [http://briterideas.com/](http://briterideas.com/).
- I have an app: [SlickShopper](https://itunes.apple.com/us/app/slickshopper-2/id434077651?mt=8). Buy a copy. Tell friends and family about how great it is so they'll buy copies too. Seriously, I'm lucky to sell one copy a week. You could literally make my month!
- I do contract development: [BriTer Ideas LLC](http://www.briterideas.com/services.shtml). Hire me. Or if you know of anyone else looking for a developer, I'd appreciate a referral.
- A shout out on Twitter never hurt anybody.
- I will graciously accept a [PayPal](http://bit.ly/AW4Cc) donation.

### Sample code

The BTIKit project includes a simple iPhone demonstration app. What it does isn't as interesting as how it does it, so be sure to review the sample classes.

### Bugs and feature requests

There is very little support offered with this code. I am always interested in better ways of doing things, so I'll be happy to consider feature requests. (Note, "consider" doesn't mean I will do anything).

(This README has been adapted from [MGWordCounter](https://github.com/mattgemmell/MGWordCounter) by Matt Gemmell)
