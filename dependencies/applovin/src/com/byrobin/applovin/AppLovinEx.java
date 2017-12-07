/*
 *
 * Created by Robin Schaafsma
 * www.byrobingames.com
 * copyright
 */

package com.byrobin.applovin;

import android.os.Bundle;
import android.view.View;
import android.app.Activity;
import android.content.Context;
import android.os.*;
import android.util.Log;
import android.content.ActivityNotFoundException;

import org.haxe.extension.Extension;
import org.haxe.lime.HaxeObject;

import com.applovin.adview.AppLovinAdView;
import com.applovin.adview.AppLovinInterstitialAd;
import com.applovin.adview.AppLovinInterstitialAdDialog;
import com.applovin.adview.AppLovinIncentivizedInterstitial;
import com.applovin.sdk.AppLovinAd;
import com.applovin.sdk.AppLovinAdClickListener;
import com.applovin.sdk.AppLovinAdDisplayListener;
import com.applovin.sdk.AppLovinAdLoadListener;
import com.applovin.sdk.AppLovinAdRewardListener;
import com.applovin.sdk.AppLovinAdSize;
import com.applovin.sdk.AppLovinAdVideoPlaybackListener;
import com.applovin.sdk.AppLovinErrorCodes;
import com.applovin.sdk.AppLovinSdk;

import android.view.Gravity;
import android.view.animation.Animation;
import android.view.animation.AlphaAnimation;
import android.view.View;
import android.view.ViewGroup.LayoutParams;
import android.widget.LinearLayout;
import android.view.ViewGroup;

import java.util.Map;

public class AppLovinEx extends Extension {


	//////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////
    private static AppLovinEx _self = null;
    protected static HaxeObject appLovinCallback;
    private static String testAds=null;
    
    //////////////////////////////////////////////////////////////////////////////////////////////////
    
    private AppLovinAdView adView;
    private LinearLayout layout;
    private AppLovinInterstitialAdDialog interstitialAdDialog;
    private AppLovinIncentivizedInterstitial incentivizedInterstitial;
    private AppLovinAd currentAd;
    
    private static int gravity=Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL;

	//////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////

	static public void init(HaxeObject cb,final String testMode){
        
        appLovinCallback = cb;
        testAds = testMode;
        
		Extension.mainActivity.runOnUiThread(new Runnable() {
            public void run() 
			{
                Log.d("AppLovinEx","Init AppLovin:");
                
                AppLovinSdk.initializeSdk(mainActivity);
                if (testMode.equals("YES")){
                    AppLovinSdk.getInstance(mainActivity).getSettings().setTestAdsEnabled(true);
                }
                
                _self.setCallbackInterstitialListeners();
			}
		});	
	}
    
    static public void loadBanner()
    {
        Extension.mainActivity.runOnUiThread(new Runnable() {
            public void run()
            {
                if(_self.adView==null){ // if this is the first time we call this function
                    _self.layout = new LinearLayout(mainActivity);
                    _self.layout.setGravity(gravity);
                } else {
                    ViewGroup parent = (ViewGroup) _self.layout.getParent();
                    parent.removeView(_self.layout);
                    _self.layout.removeView(_self.adView);
                    hideBanner();
                    //_self.adView.destroy(mainActivity);
                }
                
                _self.adView = new AppLovinAdView( AppLovinAdSize.BANNER, mainActivity );
                
                mainActivity.addContentView(_self.layout, new LayoutParams(LayoutParams.FILL_PARENT,LayoutParams.FILL_PARENT));
                _self.layout.addView(_self.adView);
                _self.layout.bringToFront();
                
                _self.adView.setAdLoadListener( new AppLovinAdLoadListener()
                                         {
                    @Override
                    public void adReceived(final AppLovinAd ad)
                    {
                        Log.d("AppLovinEx","Banner loaded");
                        hideBanner();
                        appLovinCallback.call("onBannerIsLoaded", new Object[] {});
                    }
                    
                    @Override
                    public void failedToReceiveAd(final int errorCode)
                    {
                        // Look at AppLovinErrorCodes.java for list of error codes
                        Log.d("ApplovinEx","Banner failed to load with error code " + errorCode);
                        appLovinCallback.call("onBannerFailedToLoad", new Object[] {});
                    }
                } );
                
                _self.adView.loadNextAd();
            }
        });
        
    }
    static public void showBanner()
    {
        Extension.mainActivity.runOnUiThread(new Runnable() {
            public void run()
            {
                _self.adView.setVisibility(AppLovinAdView.VISIBLE);
                
                Animation animation1 = new AlphaAnimation(0.0f, 1.0f);
                animation1.setDuration(1000);
                _self.layout.startAnimation(animation1);
            }
        });
    }
    static public void hideBanner()
    {
        Extension.mainActivity.runOnUiThread(new Runnable() {
            public void run()
            {
                Animation animation1 = new AlphaAnimation(1.0f, 0.0f);
                animation1.setDuration(1000);
                _self.layout.startAnimation(animation1);
                
                final Handler handler = new Handler();
                handler.postDelayed(new Runnable() {
                    @Override
                    public void run() {
                        _self.adView.setVisibility(AppLovinAdView.GONE);
                    }
                }, 1000);
            }
        });
    }
    static public void moveBanner(final String gravityMode)
    {
        Extension.mainActivity.runOnUiThread(new Runnable() {
            public void run()
            {
                if(gravityMode.equals("TOP"))
                {
                    if(_self.adView==null)
                    {
                        AppLovinEx.gravity=Gravity.TOP | Gravity.CENTER_HORIZONTAL;
                    }else
                    {
                        AppLovinEx.gravity=Gravity.TOP | Gravity.CENTER_HORIZONTAL;
                        _self.layout.setGravity(gravity);
                    }
                }else
                {
                    if(_self.adView==null)
                    {
                        AppLovinEx.gravity=Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL;
                    }else
                    {
                        AppLovinEx.gravity=Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL;
                        _self.layout.setGravity(gravity);
                    }
                }
            }
        });
    }
    
    
    static public void loadInterstitial()
    {
        
        Log.d("AppLovinEX","load Interstitial Begin");
        
        Extension.mainActivity.runOnUiThread(new Runnable() {
            public void run()
            {
                AppLovinSdk.getInstance(mainContext).getAdService().loadNextAd(AppLovinAdSize.INTERSTITIAL, new AppLovinAdLoadListener() {
                    @Override
                    public void adReceived(AppLovinAd ad) {
                        Log.d("AppLovinEX","Interstitial Loaded");
                        _self.currentAd = ad;
                        
                        appLovinCallback.call("onInterstitialIsLoaded", new Object[] {});
                    }
                    
                    @Override
                    public void failedToReceiveAd(int errorCode) {
                        // Look at AppLovinErrorCodes.java for list of error codes
                        Log.d("AppLovinEX","Interstitial failed to load with error code " + errorCode);
                        appLovinCallback.call("onInterstitialFailedToLoad", new Object[] {});
                    }
                });
            }
        });
        Log.d("AppLovinEX","load Interstitial End ");
    }

	static public void showInterstitial()
    {
        
        Log.d("AppLovinEX","Show Interstitial Begin");
        
		Extension.mainActivity.runOnUiThread(new Runnable() {
			public void run()
            {
                /*if(AppLovinInterstitialAd.isAdReadyToDisplay(mainActivity)){
                    // An ad is available to display.  It's safe to call show.
                    _self.interstitialAdDialog.show();
                }else{
                    // No ad is available to display.  Perform failover logic...
                }*/
                
                if (_self.currentAd != null) {
                    _self.interstitialAdDialog.showAndRender(_self.currentAd);
                }
            }
		});
		Log.d("AppLovinEX","Show Interstitial End ");
	}
    
     static public void loadRewarded()
     {
     Log.d("AppLovinEX","Load Rewarded Begin");
     Extension.mainActivity.runOnUiThread(new Runnable() {
         public void run()
        {
            _self.incentivizedInterstitial = AppLovinIncentivizedInterstitial.create(mainContext);
            _self.incentivizedInterstitial.preload(new AppLovinAdLoadListener() {
                @Override
                public void adReceived(AppLovinAd appLovinAd) {
                    Log.d("AppLovinEX","Rewarded video loaded.");
                    appLovinCallback.call("onRewardedIsLoaded", new Object[] {});
                    
                }
                
                @Override
                public void failedToReceiveAd(int errorCode) {
                    Log.d("AppLovinEX","Rewarded video failed to load with error code " + errorCode);
                    appLovinCallback.call("onRewardedFailedToLoad", new Object[] {});
                }
            });
        }
     });
     Log.d("AppLovinEX","Load Rewarded End ");
     }
    
   static public void showRewarded()
    {
        Log.d("AppLovinEX","Show Rewarded Begin");

        Extension.mainActivity.runOnUiThread(new Runnable() {
            public void run()
            {
                if (_self.incentivizedInterstitial.isAdReadyToDisplay()) {
                    
                    // Reward Listener
                    AppLovinAdRewardListener adRewardListener = new AppLovinAdRewardListener() {
                        @Override
                        public void userRewardVerified(AppLovinAd appLovinAd, Map map) {
                            // AppLovin servers validated the reward. Refresh user balance from your server.  We will also pass the number of coins
                            // awarded and the name of the currency.  However, ideally, you should verify this with your server before granting it.
                            appLovinCallback.call("onRewardedFullyWatched", new Object[] {});
                            
                            // i.e. - "Coins", "Gold", whatever you set in the dashboard.
                            String currencyName = (String) map.get("currency");
                            
                            // For example, "5" or "5.00" if you've specified an amount in the UI.
                            String amountGiven = (String) map.get("amount").toString();
                            Float f= Float.parseFloat(amountGiven);
                            String amountGivenString = String.valueOf(f);
                            
                            Log.d("AppLovinEx","Rewarded " + amountGivenString + " " + currencyName);
                            // By default we'll show a alert informing your user of the currency & amount earned.
                            // If you don't want this, you can turn it off in the Manage Apps UI.
                            appLovinCallback.call("setCurrency", new Object[] {currencyName});
                            appLovinCallback.call("setAmount", new Object[] {amountGivenString});
                        }
                        
                        @Override
                        public void userOverQuota(AppLovinAd appLovinAd, Map map) {
                            // Your user has already earned the max amount you allowed for the day at this point, so
                            // don't give them any more money. By default we'll show them a alert explaining this,
                            // though you can change that from the AppLovin dashboard.
                        }
                        
                        @Override
                        public void userRewardRejected(AppLovinAd appLovinAd, Map map) {
                            // Your user couldn't be granted a reward for this view. This could happen if you've blacklisted
                            // them, for example. Don't grant them any currency. By default we'll show them an alert explaining this,
                            // though you can change that from the AppLovin dashboard.
                        }
                        
                        @Override
                        public void validationRequestFailed(AppLovinAd appLovinAd, int responseCode) {
                            if (responseCode == AppLovinErrorCodes.INCENTIVIZED_USER_CLOSED_VIDEO) {
                                // Your user exited the video prematurely. It's up to you if you'd still like to grant
                                // a reward in this case. Most developers choose not to. Note that this case can occur
                                // after a reward was initially granted (since reward validation happens as soon as a
                                // video is launched).
                                appLovinCallback.call("onRewardedNotFullyWatched", new Object[] {});
                            } else if (responseCode == AppLovinErrorCodes.INCENTIVIZED_SERVER_TIMEOUT || responseCode == AppLovinErrorCodes.INCENTIVIZED_UNKNOWN_SERVER_ERROR) {
                                // Some server issue happened here. Don't grant a reward. By default we'll show the user
                                // a alert telling them to try again later, but you can change this in the
                                // AppLovin dashboard.
                            } else if (responseCode == AppLovinErrorCodes.INCENTIVIZED_NO_AD_PRELOADED) {
                                // Indicates that the developer called for a rewarded video before one was available.
                                // Note: This code is only possible when working with rewarded videos.
                            }
                        }
                        
                        @Override
                        public void userDeclinedToViewAd(AppLovinAd appLovinAd) {
                            // This method will be invoked if the user selected "no" when asked if they want to view an ad.
                            // If you've disabled the pre-video prompt in the "Manage Apps" UI on our website, then this method won't be called.
                            appLovinCallback.call("onRewardedNotFullyWatched", new Object[] {});
                        }
                    };
                    
                    // Video Playback Listener
                    AppLovinAdVideoPlaybackListener adVideoPlaybackListener = new AppLovinAdVideoPlaybackListener() {
                        @Override
                        public void videoPlaybackBegan(AppLovinAd appLovinAd) {
                            Log.d("AppLovinEx","Video Started");
                            appLovinCallback.call("onRewardedStarted", new Object[] {});
                        }
                        
                        @Override
                        public void videoPlaybackEnded(AppLovinAd appLovinAd, double v, boolean b) {
                            Log.d("AppLovinEx","Video Ended");
                            appLovinCallback.call("onRewardedEnded", new Object[] {});
                        }
                    };
                    
                    // Ad Dispaly Listener
                    AppLovinAdDisplayListener adDisplayListener = new AppLovinAdDisplayListener() {
                        @Override
                        public void adDisplayed(AppLovinAd appLovinAd) {
                            Log.d("AppLovinEx","Ad Displayed");
                            appLovinCallback.call("onRewardedIsDisplayed", new Object[] {});
                        }
                        
                        @Override
                        public void adHidden(AppLovinAd appLovinAd) {
                            Log.d("AppLovinEx","Ad Dismissed");
                            appLovinCallback.call("onRewardedClosed", new Object[] {});
                        }
                    };
                    
                    // Ad Click Listener
                    AppLovinAdClickListener adClickListener = new AppLovinAdClickListener() {
                        @Override
                        public void adClicked(AppLovinAd appLovinAd) {
                            Log.d("AppLovinEx","Ad Click");
                            appLovinCallback.call("onRewardedClicked", new Object[] {});
                        }
                    };
                    
                    _self.incentivizedInterstitial.show(mainActivity, adRewardListener, adVideoPlaybackListener, adDisplayListener, adClickListener);
                }
            }
        });
        Log.d("AppLovinEX","Show Rewarded End ");
    }
    
    //////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////
    
    public void setCallbackInterstitialListeners(){
        
        final AppLovinSdk sdk = AppLovinSdk.getInstance(mainContext);
        interstitialAdDialog = AppLovinInterstitialAd.create(sdk, mainActivity);
    
        /*interstitialAdDialog.setAdLoadListener(new AppLovinAdLoadListener() {
        
            @Override
            public void adReceived(AppLovinAd ad) {
                Log.d("AppLovinEx","Interstitial Loaded");
                appLovinCallback.call("onInterstitialIsLoaded", new Object[] {});
            }
        
            @Override
            public void failedToReceiveAd(int errorCode) {
                // Look at AppLovinErrorCodes.java for list of error codes
                Log.d("AppLovinEx","Interstitial failed to load with error code " + errorCode);
                appLovinCallback.call("onInterstitialFailedToLoad", new Object[] {});
            }
        });*/
        
        interstitialAdDialog.setAdDisplayListener(new AppLovinAdDisplayListener() {
            @Override
            public void adDisplayed(AppLovinAd appLovinAd) {
                // An interstitial ad was displayed.
                appLovinCallback.call("onInterstitialIsDisplayed", new Object[] {});
            }
            @Override
            public void adHidden(AppLovinAd appLovinAd) {
                // An interstitial ad was hidden.
                appLovinCallback.call("onInterstitialClosed", new Object[] {});
            }
        });
        
        interstitialAdDialog.setAdClickListener(new AppLovinAdClickListener() {
            @Override
            public void adClicked(AppLovinAd appLovinAd) {
                Log.d("AppLovinEx","Interstitial Clicked");
                appLovinCallback.call("onInterstitialClicked", new Object[] {});
            }
        });
        
        // This will only ever be used if you have video ads enabled.
        interstitialAdDialog.setAdVideoPlaybackListener(new AppLovinAdVideoPlaybackListener() {
            @Override
            public void videoPlaybackBegan(AppLovinAd appLovinAd) {
                Log.d("AppLovinEx","Video Started");
                appLovinCallback.call("onVideoStarted", new Object[] {});
            }
            
            @Override
            public void videoPlaybackEnded(AppLovinAd appLovinAd, double percentViewed, boolean wasFullyViewed) {
                Log.d("AppLovinEx","Video Ended");
                appLovinCallback.call("onVideoEnded", new Object[] {});
            }
        });
            
    }
    //////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////////////


    public void onCreate ( Bundle savedInstanceState )
    {
        super.onCreate(savedInstanceState);
        _self = this;
    }
    
    public void onResume () {
        super.onResume();
        
    }

}
