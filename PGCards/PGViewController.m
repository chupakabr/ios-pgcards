//
//  PGViewController.m
//  PGCards
//
//  Created by Valeriy Chevtaev on 2/9/12.
//  Copyright (c) 2012 7bit. All rights reserved.
//

#import "PGViewController.h"


// Available hours
#define PG_FIRST_PAGE 0
#define PG_LAST_PAGE 7
static NSInteger PG_HOURS[] = {1, 2, 3, 5, 7, 13, 21, 34};


@implementation PGViewController

@synthesize label = _label;
@synthesize pageControl = _pageControl;
@synthesize adBanner = _adBanner;
@synthesize bannerIsVisible = _bannerIsVisible;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //
    // UI defaults
    
    [self.pageControl setCurrentPage:0];
    [self.label setText:[NSString stringWithFormat:@"%d", PG_HOURS[0]]];
    
    //
    // Ads
    
    self.bannerIsVisible = YES;
    self.adBanner.delegate = self;
    
    
    //
    // Init gestures
    
    UISwipeGestureRecognizer * swipeLeft = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)] autorelease];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [self.label addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer * swipeRight = [[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRight:)] autorelease];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [self.label addGestureRecognizer:swipeRight];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.label = nil;
    self.pageControl = nil;
    self.adBanner = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationLandscapeLeft
            && interfaceOrientation != UIInterfaceOrientationLandscapeRight);
}

- (IBAction) swipeLeft:(id)sender
{
    NSInteger curPage = [self.pageControl currentPage];
    NSInteger nextPage;
    
    if (curPage == PG_LAST_PAGE) {
        nextPage = PG_FIRST_PAGE;
    } else {
        nextPage = curPage + 1;
    }
    [self.pageControl setCurrentPage:nextPage];
    
    [self.label setText:[NSString stringWithFormat:@"%d", PG_HOURS[nextPage]]];
}

- (IBAction) swipeRight:(id)sender
{
    NSInteger curPage = [self.pageControl currentPage];
    NSInteger nextPage;
    
    if (curPage == PG_FIRST_PAGE) {
        nextPage = PG_LAST_PAGE;
    } else {
        nextPage = curPage - 1;
    }
    [self.pageControl setCurrentPage:nextPage];
    
    [self.label setText:[NSString stringWithFormat:@"%d", PG_HOURS[nextPage]]];
}


#pragma mark - Ads

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    if (!willLeave)
    {
        // insert code here to suspend any services that might conflict with the advertisement
    }
    
    return YES;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    if (!self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOn" context:NULL];
        // Assumes the banner view is just off the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, -banner.frame.size.height);
        [UIView commitAnimations];
        self.bannerIsVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (self.bannerIsVisible)
    {
        [UIView beginAnimations:@"animateAdBannerOff" context:NULL];
        // Assumes the banner view is placed at the bottom of the screen.
        banner.frame = CGRectOffset(banner.frame, 0, banner.frame.size.height);
        [UIView commitAnimations];
        self.bannerIsVisible = NO;
    }
}

@end
