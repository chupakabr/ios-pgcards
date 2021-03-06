//
//  PGViewController.h
//  PGCards
//
//  Created by Valeriy Chevtaev on 2/9/12.
//  Copyright (c) 2012 7bit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface PGViewController : UIViewController<ADBannerViewDelegate>

@property (strong, nonatomic, readwrite) IBOutlet UILabel * label;
@property (strong, nonatomic, readwrite) IBOutlet UIPageControl * pageControl;
@property (strong, nonatomic, readwrite) IBOutlet ADBannerView * adBanner;
@property (assign, nonatomic, readwrite) BOOL bannerIsVisible;

- (void) swipeLeft:(id)sender;
- (void) swipeRight:(id)sender;

@end
