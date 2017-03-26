/*
 *
 * Created by Robin Schaafsma
 * www.byrobingames.com
 *
 */
#include <hx/CFFI.h>
#include <AppLovinEx.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AppLovinSDK/AppLovinSDK.h>

using namespace applovin;

extern "C" void sendAppLovinEvent(char* event, const char* data);

@interface AppLovinInterstitialController : NSObject <ALAdLoadDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate>
{

}

- (void)initSDK;
- (void)loadInterstitialAd;
- (void)showInterstitialAd;

@property (nonatomic, strong) ALAd *ad;
@end

@interface AppLovinRewardedController : NSObject <ALAdLoadDelegate, ALAdRewardDelegate, ALAdDisplayDelegate, ALAdVideoPlaybackDelegate>
{
    
}

- (void)loadRewardedAd;
- (void)showRewardedAd;

@end

@implementation AppLovinInterstitialController

- (void)initSDK
{
    NSLog(@"AppLovin Init");
    
    [ALSdk initializeSdk];
}

- (void)loadInterstitialAd
{
    NSLog(@"AppLovin: Load Interstitial/Video");
    
     [[ALSdk shared].adService loadNextAd: [ALAdSize sizeInterstitial] andNotify: self];
}


- (void)showInterstitialAd
{
    NSLog(@"AppLovin: Show Interstitial/Video");

    if ( [ALInterstitialAd isReadyForDisplay] )
    {
        //set Delegate
        //[ALInterstitialAd shared].adLoadDelegate = self;
        [ALInterstitialAd shared].adDisplayDelegate = self;
        [ALInterstitialAd shared].adVideoPlaybackDelegate = self;
        
        //[[ALInterstitialAd shared] show];
        [[ALInterstitialAd shared] showOver: [UIApplication sharedApplication].keyWindow andRender: self.ad];
        NSLog(@"AppLovin: Interstitial Shown");
    }
}


#pragma mark - Ad Load Delegate

- (void)adService:(nonnull ALAdService *)adService didLoadAd:(nonnull ALAd *)ad
{
    NSLog(@"Interstitial Loaded");
    self.ad = ad;
    sendAppLovinEvent("interstitialIsLoaded", "");
}

- (void) adService:(nonnull ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    // Look at ALErrorCodes.h for list of error codes
    NSLog(@"Interstitial failed to load with error code = %d", code);
    sendAppLovinEvent("interstitialFailedToLoad", "");
}

#pragma mark - Ad Display Delegate

- (void)ad:(nonnull ALAd *)ad wasDisplayedIn:(nonnull UIView *)view
{
    NSLog(@"Interstitial Displayed");
    sendAppLovinEvent("interstitialIsDisplayed", "");
}

- (void)ad:(nonnull ALAd *)ad wasHiddenIn:(nonnull UIView *)view
{
    NSLog(@"Interstitial Dismissed");
    sendAppLovinEvent("interstitialClosed", "");
}

- (void)ad:(nonnull ALAd *)ad wasClickedIn:(nonnull UIView *)view
{
    NSLog(@"Interstitial Clicked");
    sendAppLovinEvent("interstitialClicked", "");
}

#pragma mark - Ad Video Playback Delegate

- (void)videoPlaybackBeganInAd:(nonnull ALAd *)ad
{
    NSLog(@"Video Started");
    sendAppLovinEvent("videoStarted", "");
}

- (void)videoPlaybackEndedInAd:(nonnull ALAd *)ad atPlaybackPercent:(nonnull NSNumber *)percentPlayed fullyWatched:(BOOL)wasFullyWatched
{
    NSLog(@"Video Ended");
    sendAppLovinEvent("videoEnded", "");
}

@end

@implementation AppLovinRewardedController

- (void)loadRewardedAd
{
    NSLog(@"Load Rewardedvideo ");
    [[ALIncentivizedInterstitialAd shared] preloadAndNotify: self];
}

- (void)showRewardedAd
{
    NSLog(@"Show Rewardedvideo ");
    if ([ALIncentivizedInterstitialAd isReadyForDisplay])
    {
        [ALIncentivizedInterstitialAd shared].adDisplayDelegate = self;
        [ALIncentivizedInterstitialAd shared].adVideoPlaybackDelegate = self;
        
        [ALIncentivizedInterstitialAd showAndNotify: self];
    }
   
}
#pragma mark - Ad Load Delegate

- (void)adService:(nonnull ALAdService *)adService didLoadAd:(nonnull ALAd *)ad
{
    NSLog(@"Rewarded Loaded");
    sendAppLovinEvent("rewardedIsLoaded", "");
}

- (void) adService:(nonnull ALAdService *)adService didFailToLoadAdWithError:(int)code
{
    // Look at ALErrorCodes.h for list of error codes
    NSLog(@"Rewarded failed to load with error code = %d", code);
    sendAppLovinEvent("rewardedFailedToLoad", "");
}

#pragma mark - Ad Display Delegate

- (void)ad:(nonnull ALAd *)ad wasDisplayedIn:(nonnull UIView *)view
{
    NSLog(@"Rewarded Displayed");
    sendAppLovinEvent("rewardedIsDisplayed", "");
}

- (void)ad:(nonnull ALAd *)ad wasHiddenIn:(nonnull UIView *)view
{
    NSLog(@"Rewarded Dismissed");
    sendAppLovinEvent("rewardedClosed", "");
}

- (void)ad:(nonnull ALAd *)ad wasClickedIn:(nonnull UIView *)view
{
    NSLog(@"Rewarded Clicked");
    sendAppLovinEvent("rewardedClicked", "");
}

#pragma mark - Ad Video Playback Delegate

- (void)videoPlaybackBeganInAd:(nonnull ALAd *)ad
{
    NSLog(@"Rewarded Video Started");
    sendAppLovinEvent("rewardedStarted", "");
}

- (void)videoPlaybackEndedInAd:(nonnull ALAd *)ad atPlaybackPercent:(nonnull NSNumber *)percentPlayed fullyWatched:(BOOL)wasFullyWatched
{
    NSLog(@"Video Ended");
    sendAppLovinEvent("rewardedEnded", "");
}

#pragma mark - Ad Reward Delegate

- (void)rewardValidationRequestForAd:(ALAd *)ad didSucceedWithResponse:(nonnull NSDictionary *)response
{
    /* AppLovin servers validated the reward. Refresh user balance from your server.  We will also pass the number of coins
     awarded and the name of the currency.  However, ideally, you should verify this with your server before granting it. */
    sendAppLovinEvent("rewardedFullyWatched", "");
    
    // i.e. - "Coins", "Gold", whatever you set in the dashboard.
    //NSString *currencyName = [response objectForKey: @"currency"];
    const char *currencyName = [[response objectForKey: @"currency"] UTF8String];
    
    // For example, "5" or "5.00" if you've specified an amount in the UI.
    //NSString *amountGivenString = [response objectForKey: @"amount"];
    NSNumber *amountGiven = [NSNumber numberWithFloat: [[response objectForKey: @"amount"] floatValue]];
    NSString *amountGivenString = [amountGiven stringValue];
    const char *amount = [amountGivenString UTF8String];
    
    // Do something with this information.
    // [MYCurrencyManagerClass updateUserCurrency: currencyName withChange: amountGiven];
    //NSLog(@"Rewarded %@ %@", amountGiven, currencyName);
    sendAppLovinEvent("getCurrency", currencyName);
    sendAppLovinEvent("getAmount", amount);
    
    // By default we'll show a UIAlertView informing your user of the currency & amount earned.
    // If you don't want this, you can turn it off in the Manage Apps UI.
}

- (void)rewardValidationRequestForAd:(ALAd *)ad didFailWithError:(NSInteger)responseCode
{
    if (responseCode == kALErrorCodeIncentivizedUserClosedVideo)
    {
        sendAppLovinEvent("rewardedNotFullyWatched", "");
        // Your user exited the video prematurely. It's up to you if you'd still like to grant
        // a reward in this case. Most developers choose not to. Note that this case can occur
        // after a reward was initially granted (since reward validation happens as soon as a
        // video is launched).
    }
    else if (responseCode == kALErrorCodeIncentivizedValidationNetworkTimeout || responseCode == kALErrorCodeIncentivizedUnknownServerError)
    {
        // Some server issue happened here. Don't grant a reward. By default we'll show the user
        // a UIAlertView telling them to try again later, but you can change this in the
        // Manage Apps UI.
    }
    else if (responseCode == kALErrorCodeIncentiviziedAdNotPreloaded)
    {
        // Indicates that the developer called for a rewarded video before one was available.
    }
}

- (void)rewardValidationRequestForAd:(ALAd *)ad didExceedQuotaWithResponse:(NSDictionary *)response
{
    // Your user has already earned the max amount you allowed for the day at this point, so
    // don't give them any more money. By default we'll show them a UIAlertView explaining this,
    // though you can change that from the Manage Apps UI.
}

- (void)rewardValidationRequestForAd:(ALAd *)ad wasRejectedWithResponse:(NSDictionary *)response
{
    // Your user couldn't be granted a reward for this view. This could happen if you've blacklisted
    // them, for example. Don't grant them any currency. By default we'll show them a UIAlertView explaining this,
    // though you can change that from the Manage Apps UI.
}
@end

namespace applovin {
	
	static AppLovinInterstitialController *applovinInterstitialController;
    static AppLovinRewardedController *applovinRewardedController;
    
	void initAppLovin(){
        
        if(applovinInterstitialController == NULL)
        {
            applovinInterstitialController = [[AppLovinInterstitialController alloc] init];
        }
        
        if (applovinRewardedController == NULL) {
            
            applovinRewardedController = [[AppLovinRewardedController alloc] init];
        }

        [applovinInterstitialController initSDK];
    }
    

    void loadInterstitial()
    {
        if(applovinInterstitialController!=NULL) [applovinInterstitialController loadInterstitialAd];
    }
    
    void showInterstitial()
    {
        if(applovinInterstitialController!=NULL) [applovinInterstitialController showInterstitialAd];
    }
    
    void loadRewarded()
    {
        if(applovinRewardedController!=NULL) [applovinRewardedController loadRewardedAd];
    }
    
    void showRewarded()
    {
        if(applovinRewardedController!=NULL) [applovinRewardedController showRewardedAd];
    }
    
    
}
