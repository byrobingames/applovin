#ifndef STATIC_LINK
#define IMPLEMENT_API
#endif

#if defined(HX_WINDOWS) || defined(HX_MACOS) || defined(HX_LINUX)
#define NEKO_COMPATIBLE
#endif


#include <hx/CFFI.h>
#include "AppLovinEx.h"
#include <stdio.h>

using namespace applovin;

AutoGCRoot* appLovinEventHandle = 0;

#ifdef IPHONE

static void applovin_set_event_handle(value onEvent)
{
    appLovinEventHandle = new AutoGCRoot(onEvent);
}
DEFINE_PRIM(applovin_set_event_handle, 1);

static value applovin_init(value testmode){
	initAppLovin(val_string(testmode));
	return alloc_null();
}
DEFINE_PRIM(applovin_init,1);
//banner
static value applovin_banner_load(){
    loadBanner();
    return alloc_null();
}
DEFINE_PRIM(applovin_banner_load,0);

static value applovin_banner_show(){
    showBanner();
    return alloc_null();
}
DEFINE_PRIM(applovin_banner_show,0);

static value applovin_banner_hide(){
    hideBanner();
    return alloc_null();
}
DEFINE_PRIM(applovin_banner_hide,0);

static value applovin_banner_move(value gravity){
    moveBanner(val_string(gravity));
    return alloc_null();
}
DEFINE_PRIM(applovin_banner_move,1);

///interstitial
static value applovin_interstitial_load(){
    loadInterstitial();
    return alloc_null();
}
DEFINE_PRIM(applovin_interstitial_load,0);

static value applovin_interstitial_show(){
	showInterstitial();
	return alloc_null();
}
DEFINE_PRIM(applovin_interstitial_show,0);

static value applovin_rewarded_load(){
    loadRewarded();
    return alloc_null();
}
DEFINE_PRIM(applovin_rewarded_load,0);

static value applovin_rewarded_show(){
    showRewarded();
    return alloc_null();
}
DEFINE_PRIM(applovin_rewarded_show,0);

#endif

extern "C" void applovin_main () {
	val_int(0); // Fix Neko init
	
}
DEFINE_ENTRY_POINT (applovin_main);

extern "C" int applovin_register_prims () { return 0; }

extern "C" void sendAppLovinEvent(const char* type, const char* data)
{
    printf("Send Event: %s\n", type);
    value o = alloc_empty_object();
    alloc_field(o,val_id("type"),alloc_string(type));
    alloc_field(o,val_id("data"),alloc_string(data));
    val_call1(appLovinEventHandle->get(), o);
}
