package;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#else
import openfl.Lib;
#end

#if android
#if openfl_legacy
import openfl.utils.JNI;
#else
import lime.system.JNI;
#end
#end

import com.stencyl.Engine;
import com.stencyl.Input;
import openfl.events.MouseEvent;
import scripts.ByRobinAssets;

class AppLovin {
	
	
	private static var initialized:Bool = false;
	private static var _bannerIsLoaded:Bool=false;
	private static var _bannerFailedToLoad:Bool=false;
	private static var _interstitialIsLoaded:Bool=false;
	private static var _interstitialFailedToLoad:Bool=false;
	private static var _interstitialIsDisplayed:Bool=false;
	private static var _interstitialClosed:Bool=false;
	private static var _interstitialClicked:Bool=false;
	private static var _videoStarted:Bool=false;
	private static var _videoEnded:Bool=false;
	
	private static var _rewardedIsLoaded:Bool=false;
	private static var _rewardedFailedToLoad:Bool=false;
	private static var _rewardedIsDisplayed:Bool=false;
	private static var _rewardedClosed:Bool=false;
	private static var _rewardedClicked:Bool=false;
	private static var _rewardedStarted:Bool=false;
	private static var _rewardedEnded:Bool=false;
	private static var _rewardedFullyWatched:Bool=false;
	private static var _rewardedNotFullyWatched:Bool=false;
	
	private static var _currency:String = "";
	private static var _amount:String = "";
	
	private static var testmode:String;
	

	////////////////////////////////////////////////////////////////////////////
	#if ios
	private static var __init:String->Void = function(testMode:String){};
	private static var __applovin_set_event_handle = Lib.load("applovin","applovin_set_event_handle", 1);
	#end
	#if android
	private static var __init:Dynamic;
	#end
	private static var __loadBanner:Void->Void = function(){};
	private static var __showBanner:Void->Void = function(){};
	private static var __hideBanner:Void->Void = function(){};
	private static var __moveBanner:String->Void = function(gravity:String){};
	private static var __loadInterstitial:Void->Void = function(){};
	private static var __showInterstitial:Void->Void = function(){};
	private static var __loadRewarded:Void->Void = function(){};
	private static var __showRewarded:Void->Void = function(){};

	////////////////////////////////////////////////////////////////////////////
	
	public static function init(){
		
		if(ByRobinAssets.AppLoTestAds)
		{
			testmode = "YES";
		}else
		{
			testmode = "NO";
		}
	
		#if ios
		if(initialized) return;
		initialized = true;
		try{
			// CPP METHOD LINKING
			__init = Lib.load("applovin", "applovin_init", 1);
			__loadBanner = Lib.load("applovin", "applovin_banner_load", 0);
			__showBanner = Lib.load("applovin", "applovin_banner_show", 0);
			__hideBanner = Lib.load("applovin", "applovin_banner_hide", 0);
			__moveBanner = Lib.load("applovin", "applovin_banner_move", 1);
			__loadInterstitial = Lib.load("applovin","applovin_interstitial_load",0);
			__showInterstitial = Lib.load("applovin","applovin_interstitial_show",0);
			__loadRewarded = Lib.load("applovin","applovin_rewarded_load",0);
			__showRewarded = Lib.load("applovin","applovin_rewarded_show",0);

			__init(testmode);
			__applovin_set_event_handle(notifyListeners);
		}catch(e:Dynamic){
			trace("iOS INIT Exception: "+e);
		}
		#end
		
		#if android
		if(initialized) return;
		initialized = true;
		try{
			// JNI METHOD LINKING
			__loadBanner = JNI.createStaticMethod("com/byrobin/applovin/AppLovinEx", "loadBanner", "()V");
			__showBanner = JNI.createStaticMethod("com/byrobin/applovin/AppLovinEx", "showBanner", "()V");
			__hideBanner = JNI.createStaticMethod("com/byrobin/applovin/AppLovinEx", "hideBanner", "()V");
			__moveBanner = JNI.createStaticMethod("com/byrobin/applovin/AppLovinEx", "moveBanner", "(Ljava/lang/String;)V");
			__loadInterstitial = JNI.createStaticMethod("com/byrobin/applovin/AppLovinEx", "loadInterstitial", "()V");
			__showInterstitial = JNI.createStaticMethod("com/byrobin/applovin/AppLovinEx", "showInterstitial", "()V");
			__loadRewarded = JNI.createStaticMethod("com/byrobin/applovin/AppLovinEx", "loadRewarded", "()V");
			__showRewarded = JNI.createStaticMethod("com/byrobin/applovin/AppLovinEx", "showRewarded", "()V");
			
			if(__init == null)
			{
				__init = JNI.createStaticMethod("com/byrobin/applovin/AppLovinEx", "init", "(Lorg/haxe/lime/HaxeObject;Ljava/lang/String;)V", true);
			}
	
			var args = new Array<Dynamic>();
			args.push(new AppLovin());
			args.push(testmode);
			__init(args);
		}catch(e:Dynamic){
			trace("Android INIT Exception: "+e);
		}
		#end
	}
	
	public static function loadBanner() {
		try {
			__loadBanner();
		} catch(e:Dynamic) {
			trace("LoadBanner Exception: "+e);
		}
	}
	
	public static function showBanner() {
		try {
			__showBanner();
		} catch(e:Dynamic) {
			trace("ShowBanner Exception: "+e);
		}
	}
	
	public static function hideBanner() {
		try {
			__hideBanner();
		} catch(e:Dynamic) {
			trace("hideBanner Exception: "+e);
		}
	}
	
	public static function moveBanner(gravity:String) {
		try {
			__moveBanner(gravity);
		} catch(e:Dynamic) {
			trace("moveBanner Exception: "+e);
		}
	}
	
	public static function loadInterstitial() {
		try {
			__loadInterstitial();
		} catch(e:Dynamic) {
			trace("LoadInterstitial Exception: "+e);
		}
	}
	
	
	public static function showInterstitial() {
		try {
			__showInterstitial();
		} catch(e:Dynamic) {
			trace("ShowInterstitial Exception: "+e);
		}
	}
	
	public static function loadRewarded() {
		try {
			__loadRewarded();
		} catch(e:Dynamic) {
			trace("LoadRewardedVideo Exception: "+e);
		}
	}
	
	public static function showRewarded() {
		try {
			__showRewarded();
		} catch(e:Dynamic) {
			trace("ShowRewardedVideo Exception: "+e);
		}
	}
	////////
	public static function bannerIsLoaded():Bool{
		
		if(_bannerIsLoaded){
			_bannerIsLoaded = false;
			return true;
		}
		
		return false;
	}
	
	public static function bannerFailedToLoad():Bool{
		
		if(_bannerFailedToLoad){
			_bannerFailedToLoad = false;
			return true;
		}
		
		return false;
	}
	
	public static function interstitialIsLoaded():Bool{
		
		if(_interstitialIsLoaded){
			_interstitialIsLoaded = false;
			return true;
		}
		
		return false;
	}
	
	public static function interstitialFailedToLoad():Bool{
		
		if(_interstitialFailedToLoad){
			_interstitialFailedToLoad = false;
			return true;
		}
		
		return false;
	}
	
	public static function interstitialIsDisplayed():Bool{
		
		if(_interstitialIsDisplayed){
			_interstitialIsDisplayed = false;
			return true;
		}
		
		return false;
	}
	
	public static function interstitialClosed():Bool{
		
		if(_interstitialClosed){
			_interstitialClosed = false;
			return true;
		}
		
		return false;
	}
	
	public static function interstitialClicked():Bool{
		
		if(_interstitialClicked){	
			_interstitialClicked = false;
			return true;
		}
		
		return false;
	}
	
	public static function videoStarted():Bool{
		
		if(_videoStarted){
			_videoStarted = false;
			return true;
		}
		
		return false;
	}
	
	public static function videoEnded():Bool{
		
		if(_videoEnded){
			_videoEnded = false;
			return true;
		}
		
		return false;
	}
	
	public static function rewardedIsLoaded():Bool{
		
		if(_rewardedIsLoaded){
			_rewardedIsLoaded = false;
			return true;
		}
		
		return false;
	}
	
	public static function rewardedFailedToLoad():Bool{
		
		if(_rewardedFailedToLoad){
			_rewardedFailedToLoad = false;
			return true;
		}
		
		return false;
	}
	
	public static function rewardedClosed():Bool{
		
		if(_rewardedClosed){
			_rewardedClosed = false;
			return true;
		}
		
		return false;
	}
	
	public static function rewardedClicked():Bool{
		
		if(_rewardedClicked){	
			_rewardedClicked = false;
			return true;
		}
		
		return false;
	}
	
	public static function rewardedStarted():Bool{
		
		if(_rewardedStarted){
			_rewardedStarted = false;
			return true;
		}
		
		return false;
	}
	
	public static function rewardedEnded():Bool{
		
		if(_rewardedEnded){
			_rewardedEnded = false;
			return true;
		}
		
		return false;
	}
	
	public static function rewardedFullyWatched():Bool{
		
		if(_rewardedFullyWatched){
			_rewardedFullyWatched = false;
			return true;
		}
		
		return false;
	}
	
	public static function rewardedNotFullyWatched():Bool{
		
		if(_rewardedNotFullyWatched){
			_rewardedNotFullyWatched = false;
			return true;
		}
		
		return false;
	}
	
	public static function getCurrency():String{
		
		return _currency;
	}
	
	public static function getAmount():String{
		
		return _amount;
	}
	
	///////Events Callbacks/////////////
	
	#if ios
	//Ads Events only happen on iOS.
	private static function notifyListeners(inEvent:Dynamic)
	{
		var event:String = Std.string(Reflect.field(inEvent, "type"));
		var data:String = Std.string(Reflect.field(inEvent, "data"));
		
		if(event == "bannerIsLoaded")
		{
			_bannerIsLoaded = true;
		}
		if(event == "bannerfailedtoLoaded")
		{
			_bannerFailedToLoad = true;
		}
		if(event == "interstitialIsLoaded")
		{
			_interstitialIsLoaded = true;
		}
		if(event == "interstitialFailedToLoad")
		{
			trace("Interstitial FAILED TO LOAD");
			_interstitialFailedToLoad = true;
		}
		if(event == "interstitialIsDisplayed")
		{
			trace("INTERSTITIAL IS DISPLAYED");
			_interstitialIsDisplayed = true;
		}
		if(event == "interstitialClosed")
		{
			trace("INTERSTITIAL CLOSED");
			_interstitialClosed = true;
		}
		if(event == "interstitialClicked")
		{
			trace("INTERSTITIAL CLICKED");
			_interstitialClicked = true;
		}
		if(event == "videoStarted")
		{
			trace("VIDEO STARTED");
			_videoStarted = true;
		}
		if(event == "videoEnded")
		{
			trace("VIDEO ENDED");
			_videoEnded = true;
		}
		if(event == "rewardedIsLoaded")
		{
			trace("REWARDED IS LOADED");
			_rewardedIsLoaded = true;
		}
		if(event == "rewardedFailedToLoad")
		{
			trace("REWARDED FAIL TO LOAD");
			_rewardedFailedToLoad = true;
		}
		if(event == "rewardedIsDisplayed")
		{
			trace("REWARDED IS DISPLAYED");
			_rewardedIsDisplayed = true;
		}
		if(event == "rewardedClosed")
		{
			trace("REWARDED CLOSED");
			_rewardedClosed = true;
		}
		if(event == "rewardedClicked")
		{
			trace("REWARDED CLICKED");
			_rewardedClicked = true;
		}
		if(event == "rewardedStarted")
		{
			trace("REWARDED STARTED");
			_rewardedStarted = true;
		}
		if(event == "rewardedEnded")
		{
			trace("REWARDED ENDED");
			_rewardedEnded = true;
		}
		if(event == "rewardedFullyWatched")
		{
			trace("REWARDED FULLY WATCHED");
			_rewardedFullyWatched = true;
		}
		if(event == "rewardedNotFullyWatched")
		{
			trace("REWARDED NOT FULLY WATCHED");
			_rewardedNotFullyWatched = true;
			_currency = "";
			_amount = "";
		}
		if(event == "getCurrency")
		{
			_currency = data;
		}
		if(event == "getAmount")
		{
			_amount = data;
		}
	}
	#end
	
	#if android
	private function new() {}
	
	public function onBannerIsLoaded() 
	{
		_bannerIsLoaded = true;
	}
	public function onBannerFailedToLoad() 
	{
		_bannerFailedToLoad = true;
	}
	public function onInterstitialIsLoaded() 
	{
		_interstitialIsLoaded = true;
	}
	public function onInterstitialFailedToLoad() 
	{
		_interstitialFailedToLoad = true;
	}
	public function onInterstitialIsDisplayed() 
	{
		_interstitialIsDisplayed = true;
	}
	public function onInterstitialClosed() 
	{
		_interstitialClosed = true;
	}
	public function onInterstitialClicked() 
	{
		_interstitialClicked = true;
	}
	public function onVideoStarted() 
	{
		_videoStarted = true;
	}
	public function onVideoEnded() 
	{
		_videoEnded = true;
	}
	
	//rewarded
	public function onRewardedIsLoaded() 
	{
		_rewardedIsLoaded = true;
	}
	public function onRewardedFailedToLoad()
	{
		_rewardedFailedToLoad = true;
	}
	public function onRewardedIsDisplayed() 
	{
		_rewardedIsDisplayed = true;
	}
	public function onRewardedClosed()
	{
		_rewardedClosed = true;
	}
	public function onRewardedClicked() 
	{
		_rewardedClicked = true;
	}
	public function onRewardedStarted()
	{
		_rewardedStarted = true;
	}
	public function onRewardedEnded() 
	{
		_rewardedEnded = true;
	}
	public function onRewardedFullyWatched()
	{
		_rewardedFullyWatched = true;
	}
	public function onRewardedNotFullyWatched()
	{
		_rewardedNotFullyWatched = true;
	}
	public function setCurrency(currency:String)
	{
		_currency = currency;
	}
	public function setAmount(amount:String)
	{
		_amount = amount;
	}
	#end

}