import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

extension LottiesExtenstion on String {
  Widget build({
    double? height,
    double? width,
    bool repeat = false,
  }) {
    if (startsWith("http")) {
      return Lottie.network(
        this,
        repeat: repeat,
        height: height,
      );
    }
    return Lottie.asset(
      this,
      repeat: repeat,
      height: height,
    );
  }
}

abstract class AppLottie {
  static const root = 'assets/lotties';
  static const syncing1 = "$root/sync1.json";
  static const splash = "$root/Fitarc Splash Lottie.json";
  static const loader = "$root/Loader.json";
  static const syncing2 = "$root/sync2.json";
  static const somethingWentWrong = "$root/something_went_wrong.json";
  static const noInternet = "$root/no_internet.json";
  static const emptyBox = "$root/empty_view.json";
  static const update = "$root/update.json";
  static const bg_login = "$root/bg_login.json";
  static const lottie = "$root/empty_view.json";
  static const donwloaded = "https://assets4.lottiefiles.com/packages/lf20_rhav6mis.json";
}