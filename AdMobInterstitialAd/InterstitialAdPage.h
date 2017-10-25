//
//  InterstitialAdPage.h
//  InterstitialAd
//
//  Created by Mohammed Mansour on 10/24/17.
//  Copyright © 2017 Mohammed Mansour. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMobileAds/GADInterstitial.h>//;
#import <GoogleMobileAds/GADInterstitialDelegate.h>//;

@interface InterstitialAdPage : NSObject

@property(nonatomic, strong) GADInterstitial *interstitial;

@property(nonatomic, strong) UIViewController *rootViewController;

@property(nonatomic, strong) NSString *testDevice;

- (id)initWithAdUnitId:(NSString*)adUnitId andWithRootViewController:(UIViewController *) rootViewController;

- (void) requestAd;

- (BOOL) isReady;

- (void)  fireAd;
@end
