#ifndef APPLOVINEX_H
#define APPLOVINEX_H


namespace applovin {
	
	
	void initAppLovin(const char *testmode);
    void loadInterstitial();
	void showInterstitial();
    void loadRewarded();
    void showRewarded();
    void loadBanner();
    void showBanner();
    void hideBanner();
    void moveBanner(const char *gravity);
    void setHasUserConsent(bool isGranted);
    void setIsAgeRestricted(bool isGranted);
    bool getHasUserConsent();
    bool getIsAgeRestricted();
}


#endif
