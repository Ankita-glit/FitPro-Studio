import 'package:firstdayappsuccessor/screens/splash/splashcontroller.dart';
import 'package:firstdayappsuccessor/screens/widgets/app_lotties.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Splashview extends GetView<SplashController> {
  const Splashview({super.key});

  @override
  Widget build(BuildContext context) {
    controller.navigateToView(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Center(
          child: AppLottie.splash.build(),
        ),
      ),

    );
  }
}
