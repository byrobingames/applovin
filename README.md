## Stencyl AppLovin Advertising Extension (Openfl)

For Stencyl 3.4 9280 and above

Stencyl extension for “AppLovin” (http://www.applovin.com) for iOS and Android. This extension allows you to easily integrate AppLovin on your Stencyl game / application. (http://www.stencyl.com)

### Important!!

This Extension Required the Toolset Extension Manager [https://byrobingames.github.io](https://byrobingames.github.io)

![applovintoolset](https://byrobingames.github.io/img/applovin/applovintoolset.png)

## Main Features

  * Interstitial/Video Support.
  * Rewarded Video Support.
  
**GDPR Compliance** <br/>
Under Privacy Settings in your Appovin Dashboard you can enable GDPR Compliance for EU.

Set Consent and Age Restricted programmatically See documantation and block section. 
  
## How to Install

To install this Engine Extension, go to the toolset (byRobin Extension Mananger) in the Extension menu of your game inside Stencyl.<br/>
![toolsetextensionlocation](https://byrobingames.github.io/img/toolset/toolsetextensionlocation.png)<br/>
Select the Extension from the menu and click on "Download"

If you not have byRobin Extension Mananger installed, install this first.<br/>
Go to: [https://byrobingames.github.io](https://byrobingames.github.io)

## Documentation and Block Examples

If you don’t have an account, create one on [http://www.applovin.com](http://www.applovin.com) and get your SDK KEY.

<span style="color:red;">!!ON ANDROID YOU NEED TO ENABLE ADMOB ADS INSIDE STENCYL!!</span>

Enter your SDK Key on the “AppLovinPage” in the Toolset.<br/>
![applovinsdkkey](https://byrobingames.github.io/img/applovin/applovinsdkkey.png)<br/>

Enable Testads on the “AppLovinPage” in the Toolset.<br/>
![applovinenbaletestads](https://byrobingames.github.io/img/applovin/applovinenbaletestads.png)

**Blocks**

  * Initialize AppLovin<br/>
  ![applovininitialize](https://byrobingames.github.io/img/applovin/applovininitialize.png)
  
  <hr/>
  
  * Load/Show AppLovin Interstitial/Video<br/>
  ![applovinloadshowinterstitial](https://byrobingames.github.io/img/applovin/applovinloadshowinterstitial.png)
  
  <hr/>
  
  * Load/Show AppLovin Rewarded Video<br/>
  ![applovinloadshowrewarded](https://byrobingames.github.io/img/applovin/applovinloadshowrewarded.png)
  
  <hr/>
  
  * Load/Show/Hide AppLovin Banner<br/>
  ![applovinbanner](https://byrobingames.github.io/img/applovin/applovinbanner.png)
  
  <hr/>
  
  * Callback for Banner<br/>
  ![applovinbannercallbacks](https://byrobingames.github.io/img/applovin/applovinbannercallbacks.png)
  
  <hr/>
  
  * Callback for Interstitial/Video and Rewarded Video<br/>
  ![callbacks](https://byrobingames.github.io/img/applovin/callbacks.png)
  
  <hr/>
  
  * Get Currency/Amount of Rewarded Video<br/>
   ![applovingetcurrencyamount](https://byrobingames.github.io/img/applovin/applovingetcurrencyamount.png)
   
   <hr/>
   
### Privacy Settings
   
AppLovin SDK requires that publishers set a flag indicating whether a user located in the European Economic Area (i.e., EAA/GDPR data subject) has provided opt-in consent for the collection and use of personal data.
   
For users outside the EAA, this flag is not required to be set in the SDK and if set, will not impact how the ad is served to such non-EAA users.

**Set "has user consented"** (Europe users only)<br/>
- If the user has consented, please set the following flag to YES.<br/>
- If the user has not consented, please set the following flag to NO.<br/>

![applovinsetconsent](https://byrobingames.github.io/img/applovin/applovinsetconsent.png)

**Get "has user consented"** (Europe users only)<br/>
Return true(YES) of false(NO) after user has consented.<br/>
![applovinsetconsent](https://byrobingames.github.io/img/applovin/applovingetconsent.png)

**Set "is user age restricted"** <br/>
- If the user is known to be in an age-restricted category (i.e., under the age of 16) please set the following flag to YES.<br/>
- If the user is known to not be in an age-restricted category (i.e., age 16 or older) please set the following flag to NO.<br/>

![applovinsetagerestricted](https://byrobingames.github.io/img/applovin/applovinsetagerestricted.png)

**Get "is user age restricted"** <br/>
Return true(YES) of false(NO) if user is age restricted.<br/>
![applovinsetagerestricted](https://byrobingames.github.io/img/applovin/applovingetagerestricted.png)

## Version History

- 2016-03-28 (0.0.1) First release
- 2016-09-25 (0.0.2) Update iOS SDK to 3.4.3 and Android SDK to 6.3.2
- 2016-11-18 (0.0.3) Updated for Heyzap extension 2.7
- 2017-03-19 (0.0.4) Updated to use with Heyzap Extension 2.9, Update SDK to iOS: 3.5.2 Android: 6.4.2, Added Android Gradle support for openfl4
- 2017-05-16(0.0.5) Update SDK to iOS: 4.02 Android: 7.0.3, Tested for Stencyl 3.5, Required byRobin Toolset Extension Manager
- 2017-07-29(0.0.6) Downgrade SDK to iOS: 3.5.2 Android:6.4.2, works stable with Heyzap.
- 2017-12-07(0.0.7) Update AppLovin SDK to iOS: 4.6.0 Android:7.6.0, added banner support use byRobin Toolset manager =>v5
- 2019-01-01(0.0.8) Update AppLovin SDK to iOS: 6.1.4 Android:9.1.3
- 2019-01-07(0.0.9) Added set/get Consent and set/get Age Restricted block.

## Submitting a Pull Request

This software is opensource.<br/>
If you want to contribute you can make a pull request

Repository: [https://github.com/byrobingames/applovin](https://github.com/byrobingames/applovin)

Need help with a pull request?<br/>
[https://help.github.com/articles/creating-a-pull-request/](https://help.github.com/articles/creating-a-pull-request/)

### ANY ISSUES?

Add the issue on GitHub<br/>
Repository: [https://github.com/byrobingames/applovin/issues](https://github.com/byrobingames/applovin/issues)

Need help with creating a issue?<br/>
[https://help.github.com/articles/creating-an-issue/](https://help.github.com/articles/creating-an-issue/)

## Donate

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=HKLGFCAGKBMFL)<br />

## Privacy Policy

[http://www.applovin.com](http://www.applovin.com)

## License

Author: Robin Schaafsma

The MIT License (MIT)

Copyright (c) 2014 byRobinGames [http://www.byrobin.nl](http://www.byrobin.nl)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
