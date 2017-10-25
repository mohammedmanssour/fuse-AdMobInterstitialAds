//
//  Author: Mohammed Manssour
//  Blog: http://helilabs.com
//  Fuse Community: https://www.facebook.com/groups/fusetools/
//  License: MIT
//

using Fuse;
using Fuse.Scripting;
using Fuse.Reactive;
using Uno.UX;
using Uno;
using Uno.Compiler.ExportTargetInterop;

namespace AdMobInterstitialAd{

	[UXGlobalModule]
	public class InterstitialAd : NativeEventEmitterModule{
		static InterstitialAd _instance;

		public AdPage ad;

		public InterstitialAd() : base(true, "adReady")
		{
			if (_instance != null) return;
			_instance = this;

			Uno.UX.Resource.SetGlobalKey(_instance, "AdMobInterstitialAd");
			AddMember(new NativeFunction("initAd", (NativeCallback)initAd));
			AddMember(new NativeFunction("isReady", (NativeCallback)isReady));
			AddMember(new NativeFunction("fireAd", (NativeCallback)fireAd));
		}

		object initAd(Context c, object[] args)
		{
			this.ad = new AdPage( args[0].ToString() );
			return null;
		}

		object isReady(Context c, object[] args)
		{
			if( this.ad.isReady() ){
				Emit("adReady");
			}
			return null;
		}

		object fireAd(Context c, object[] args)
		{
			this.ad.fireAd();
			return null;
		}

	}

	[Require("Gradle.Repository", "maven { url 'https://maven.google.com' }")]
	[Require("Gradle.Dependency.ClassPath", "com.google.gms:google-services:3.1.1")]
	[Require("Gradle.Dependency.Compile", "com.google.firebase:firebase-core:11.4.2")]
	[Require("Gradle.Dependency.Compile", "com.google.firebase:firebase-ads:11.4.2")]
	[Require("Gradle.BuildFile.End", "apply plugin: 'com.google.gms.google-services'")]
	[ForeignInclude(Language.Java, "com.fuse.Activity")]
	[ForeignInclude(Language.Java, "com.foreign.InterstitialAd")]
	[ForeignInclude(Language.Java, "com.google.android.gms.ads.MobileAds")]
	[ForeignInclude(Language.Java, "android.util.Log")]

	[Require("Cocoapods.Podfile.Target", "pod 'Firebase/Core'")]
	[Require("Cocoapods.Podfile.Target", "pod 'Firebase/AdMob'")]
	[ForeignInclude(Language.ObjC, "InterstitialAdPage.h")] //[Require("Source.Import", "InterstitialAdPage.h")]
	public class AdPage{

		static bool _initialized = false;

		public string adUnitId;

		public extern(iOS) ObjC.Object ad;
		public extern(Android) Java.Object ad;

		public AdPage( string adUnitId )
		{
			//if( !_initialized ){
			//	initialize();
			//	_initialized = true;
			//}

			this.adUnitId = adUnitId;
			startAd();
		}

		//============================================
		// Android
		//============================================

		[Foreign(Language.ObjC)]
		public extern(iOS) void startAd()
		@{

			NSString* originalString = @{AdPage:Of(_this).adUnitId:Get()};

			InterstitialAdPage *interstitial = [[InterstitialAdPage alloc] initWithAdUnitId:[originalString stringByAppendingString: @""]
																			andWithRootViewController: [UIApplication sharedApplication].keyWindow.rootViewController];
			NSString* testDevice = @"@(Project.Android.AdMob.testDevice)";
			interstitial.testDevice = testDevice;

			[interstitial requestAd];

			@{AdPage:Of(_this).ad:Set(interstitial)};
		@}

		[Foreign(Language.ObjC)]
		public extern(iOS) bool isReady()
		@{
			id ad = @{AdPage:Of(_this).ad:Get()};

			InterstitialAdPage *interstitial = (InterstitialAdPage *) ad;

			return [interstitial isReady];
		@}

		[Foreign(Language.ObjC)]
		public extern(iOS) void fireAd()
		@{
			id ad = @{AdPage:Of(_this).ad:Get()};

			InterstitialAdPage *interstitial = (InterstitialAdPage *) ad;

			[interstitial fireAd];
		@}


		//============================================
		// Android
		//============================================
		[Foreign(Language.Java)]
		public extern(Android) void initialize()
		@{
			Log.d("Ad initialize","initialize");
			MobileAds.initialize(Activity.getRootActivity(), "@(Project.Android.AdMob.appID)");
		@}

		[Foreign(Language.Java)]
		public extern(Android) void startAd()
		@{
			String adUnitId = @{AdPage:Of(_this).adUnitId:Get()};
			InterstitialAd interstitial = new InterstitialAd( adUnitId + "" , Activity.getRootActivity() );

			String testDevice = "@(Project.Android.AdMob.testDevice)";

			if( !testDevice.isEmpty() ){
				interstitial.setTestDevice( testDevice );
			}
			interstitial.loadRequest();

			@{AdPage:Of(_this).ad:Set(interstitial)};
		@}

		[Foreign(Language.Java)]
		public extern(Android) bool isReady()
		@{
			Object ad = @{AdPage:Of(_this).ad:Get()};

			InterstitialAd interstitial = (InterstitialAd) ad;

			return interstitial.isReady();
		@}

		[Foreign(Language.Java)]
		public extern(Android) void fireAd()
		@{
			Object ad = @{AdPage:Of(_this).ad:Get()};

			InterstitialAd interstitial = (InterstitialAd) ad;

			interstitial.fireAd();
		@}

		//============================================
		// Preview
		//============================================
		public extern(!Android) void initialize()
		{
			debug_log("no need to initialize");
		}

		public extern(!mobile) void startAd()
		{
			debug_log("can't show a Interstitial Ad on preview");
		}

		public extern(!mobile) bool isReady()
		{
			debug_log("isReady always returns false on preview");
			return false;
		}

		public extern(!mobile) void fireAd()
		{
			debug_log("can't show a Interstitial Ad on preview");
		}

	}
}