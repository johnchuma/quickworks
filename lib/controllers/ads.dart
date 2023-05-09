import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:quickworks/utils/colors.dart';

void loadAds(Function function) {
  RewardedAd? rewardedAd;
  const adUnitId = "ca-app-pub-7465129197989931/2564084977";
  Get.defaultDialog(
      title: "Wait...",
      content: CircularProgressIndicator(
        color: primary,
      ));
  RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          debugPrint('$ad loaded.');
          rewardedAd = ad;
          Get.back();
          rewardedAd?.show(
              onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
            function();
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedAd failed to load: $error');
        },
      ));
}

BannerAd bannerAd() {
  const adUnitId = "ca-app-pub-7465129197989931/6618061817";
  return BannerAd(
    adUnitId: adUnitId,
    request: const AdRequest(),
    size: AdSize.banner,
    listener: BannerAdListener(
      // Called when an ad is successfully received.
      onAdLoaded: (ad) {
        debugPrint('$ad loaded.');
      },
      // Called when an ad request failed.
      onAdFailedToLoad: (ad, err) {
        debugPrint('BannerAd failed to load: $err');
        // Dispose the ad here to free resources.
        ad.dispose();
      },
    ),
  )..load();
}
