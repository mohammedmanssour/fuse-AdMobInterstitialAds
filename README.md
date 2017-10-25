## AdMob Interstitial Ad
Implement AdMob Interstitial Ad In Your Fuse Project

License: MIT

### How to use
This package detects Ad Status throgh listeners, to install it in your App you just have to
1. in your `unoproj` file add the following
    ```
    "Android": {
        "Package": "com.isagha.isagha",
        "AdMob" : {
    	    "appID" : "appIDHere",
    	    "testDevice" : "" // set it if you want to test using device id
        }
    },
    ```
2. copy your `google-service.json` file to your app root path.
3. copy your `GoogleService-Info.plist` to your app root path.
4. include `GoogleService-Info.plist` in `unoproj` file
    ```
    "Includes": [
        "*",
        "GoogleService-Info.plist:ObjCSource:iOS"
    ],
    ```
5. require `AdMobInterstitialAd` Module.
6. call function `initAd`.
    ```
    var AdMobInterstitialAd = require('AdMobInterstitialAd');
    AdMobInterstitialAd.initAd("adUnitIdHere");
    ```

### Contributers

1. [Mohammed Manssour](http://helilabs.com)