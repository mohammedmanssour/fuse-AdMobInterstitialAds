package com.foreign;

import android.app.Activity;
import android.util.Log;

import com.google.android.gms.ads.AdListener;
import com.google.android.gms.ads.AdRequest;

/**
 * Created by mhdmansour on 10/25/17.
 */

public class InterstitialAd extends AdListener {

    private com.google.android.gms.ads.InterstitialAd mInterstitialAd;

    private Activity activity;

    private String testDevice = "";

    public InterstitialAd(String adUnitId, Activity activity){

        this.activity = activity;
        this.mInterstitialAd = new com.google.android.gms.ads.InterstitialAd( this.activity );
        this.mInterstitialAd.setAdUnitId( adUnitId );
        this.mInterstitialAd.setAdListener(this);
    }

    @Override
    public void onAdLoaded() {
        // Code to be executed when an ad finishes loading.
        Log.i("Ads", "onAdLoaded");

        if (this.mInterstitialAd.isLoaded()) {
            this.mInterstitialAd.show();
        }
    }

    @Override
    public void onAdFailedToLoad(int errorCode) {
        // Code to be executed when an ad request fails.
        Log.i("Ads", "onAdFailedToLoad");

    }

    @Override
    public void onAdClosed() {

    }

    public boolean isReady(){
        return this.mInterstitialAd.isLoaded();
    }

    public void fireAd(){
        this.mInterstitialAd.show();
    }

    public InterstitialAd setTestDevice(String testDevice){
        this.testDevice = testDevice;
        return this;
    }

    public void loadRequest(){

        AdRequest.Builder adRequestBuilder = new AdRequest.Builder();

        if( !this.testDevice.isEmpty() ){
            adRequestBuilder.addTestDevice( this.testDevice );
        }

        final AdRequest adRequest = adRequestBuilder.build();

        this.activity.runOnUiThread(new Runnable() {
            @Override
            public void run() {
                mInterstitialAd.loadAd(adRequest);
            }
        });

    }
}
