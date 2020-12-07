import 'package:firebase_admob/firebase_admob.dart';
import 'dart:io';

class AdMobService {
  static AdMobService _instance;

  String get _adMobAppId {
    if (Platform.isIOS) {
      return null;
    }
    return "ca-app-pub-6353563769889261~3100820800";
    //return "ca-app-pub-3940256099942544~3347511713";
  }

  BannerAd _homeBannerAd;
  InterstitialAd _interstitialAd;

  String get bannerId => "ca-app-pub-6353563769889261/3230002687";
  //String get bannerId => BannerAd.testAdUnitId;

  String get _interstitialId => "ca-app-pub-6353563769889261/8325227328";
  //String get _interstitialId => InterstitialAd.testAdUnitId;

  static AdMobService getInstance() {
    if (_instance == null) {
      _instance = AdMobService();
    }
    return _instance;
  }

  static const String _testDevice = 'MObile_id';

  //MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
  //  testDevices: _testDevice != null ? <String>[_testDevice] : null,
  //  nonPersonalizedAds: true,
  //  keywords: <String>['Game', 'Mario', 'Mario Kart', 'Nintendo', 'Switch'],
  //);

  BannerAd _createBannerAd() {
    //FirebaseAdMob.instance.initialize(appId: _adMobAppId);
    return BannerAd(
      adUnitId: bannerId,
      size: AdSize.smartBanner,
      listener: (MobileAdEvent event) {},
    );
  }

  void showHomeBannerAd() {
    _homeBannerAd = _createBannerAd();
    _homeBannerAd
      ..load()
      ..show(anchorType: AnchorType.bottom, anchorOffset: 100);
  }

  void hideHomeBannerAd() async {
    await _homeBannerAd.dispose();
    _homeBannerAd = null;
  }

  InterstitialAd _createInterstitialAd() {
    //FirebaseAdMob.instance.initialize(appId: _interstitialId);
    return InterstitialAd(
      adUnitId: _interstitialId,
      listener: (MobileAdEvent event) {},
    );
  }

  void showInterstitialAd() {
    _interstitialAd = _createInterstitialAd();
    _interstitialAd
      ..load()
      ..show();
  }
}
