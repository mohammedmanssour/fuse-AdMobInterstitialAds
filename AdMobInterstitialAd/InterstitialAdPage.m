//
//  InterstitialAdPage.m
//  InterstitialAd
//
//  Created by Mohammed Mansour on 10/24/17.
//  Copyright © 2017 Mohammed Mansour. All rights reserved.
//

#import "InterstitialAdPage.h"

@interface InterstitialAdPage () <GADInterstitialDelegate>

@end

@implementation InterstitialAdPage


- (id)initWithAdUnitId:(NSString*)adUnitId andWithRootViewController:(UIViewController *) rootViewController {

if ((self = [super init])) {
        self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:adUnitId];
        self.rootViewController = rootViewController;

        self.interstitial.delegate = self;
    }
    return self;
}

- (void) requestAd{
    GADRequest *request = [GADRequest request];

    if( [self.testDevice length] != 0 ){
        request.testDevices = @[ self.testDevice ];
    }

    [self.interstitial loadRequest:request];
}

- (BOOL) isReady{
	return self.interstitial.isReady;
}

- (void) fireAd{
	[self.interstitial presentFromRootViewController:self.rootViewController];
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    NSLog(@"interstitialDidReceiveAd");
    if (self.interstitial.isReady) {
        [self.interstitial presentFromRootViewController:self.rootViewController];
    }
}

/// Tells the delegate an ad request failed.
- (void)interstitial:(GADInterstitial *)ad
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitial:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that an interstitial will be presented.
- (void)interstitialWillPresentScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillPresentScreen");
}

/// Tells the delegate the interstitial is to be animated off the screen.
- (void)interstitialWillDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialWillDismissScreen");
}

/// Tells the delegate the interstitial had been animated off the screen.
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad {
    NSLog(@"interstitialDidDismissScreen");
}

/// Tells the delegate that a user click will open another app
/// (such as the App Store), backgrounding the current app.
- (void)interstitialWillLeaveApplication:(GADInterstitial *)ad {
    NSLog(@"interstitialWillLeaveApplication");
}


@end
