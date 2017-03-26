package;

#if cpp
import cpp.Lib;
#elseif neko
import neko.Lib;
#else
import openfl.Lib;
#end

#if android
import openfl.utils.JNI;
#end

import com.stencyl.Engine;
import com.stencyl.Input;
import openfl.events.MouseEvent;

class AppLovin {
	
	private static var initialized:Bool=false;
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
	

	////////////////////////////////////////////////////////////////////////////
	#if ios
	private static var __init:Void->Void = function(){};
	private static var __applovin_set_event_handle = Lib.load("applovin","applovin_set_event_handle", 1);
	#end
	#if android
	private static var __init:Dynamic;
	#end
	private static var __loadInterstitial:Void->Void = function(){};
	private static var __showInterstitial:Void->Void = function(){};
	private static var __loadRewarded:Void->Void = function(){};
	private static var __showRewarded:Void->Void = function(){};

	////////////////////////////////////////////////////////////////////////////
	
	public static function init(){
	
		#if ios
		if(initialized) return;
		initialized = true;
		try{
			// CPP METHOD LINKING
			__init = Lib.load("applovin","applovin_init",0);
			__loadInterstitial = Lib.load("applovin","applovin_interstitial_load",0);
			__showInterstitial = Lib.load("applovin","applovin_interstitial_show",0);
			__loadRewarded = Lib.load("applovin","applovin_rewarded_load",0);
			__showRewarded = Lib.load("applovin","applovin_rewarded_show",0);

			__init();
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
			__loadInterstitial = openfl.utils.JNI.createStaticMethod("com/byrobin/applovin/AppLovinEx", "loadInterstitial", "()V");
			__showInterstitial = openfl.utils.JNI.createStaticMethod("com/byrobin/applovin/AppLovinEx", "showInterstitial", "()V");
			__loadRewarded = openfl.utils.JNI.createStaticMethod("com/byrobin/applovin/AppLovinEx", "loadRewarded", "()V");
			__showRewarded = openfl.utils.JNI.createStaticMethod("com/byrobin/applovin/AppLovinEx", "showRewarded", "()V");
			
			if(__init == null)
			{
				__init = JNI.createStaticMethod("com/byrobin/applovin/AppLovinEx", "init", "(Lorg/haxe/lime/HaxeObject;)V", true);
			}
	
			var args = new Array<Dynamic>();
			args.push(new AppLovin());
			__init(args);
		}catch(e:Dynamic){
			trace("Android INIT Exception: "+e);
		}
		#end
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