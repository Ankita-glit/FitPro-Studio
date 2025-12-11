import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firstdayappsuccessor/screens/widgets/app_lotties.dart';

class LoadingOverlay extends StatelessWidget {
  final RxBool isLoading;
  final double height;
  final double width;

  const LoadingOverlay({
    Key? key,
    required this.isLoading,
    this.height = 40,
    this.width = 40,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return isLoading.value
          ? Positioned.fill(
        child: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                color: Colors.black.withOpacity(0.2),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Container(
                  height: height,
                  width: width,
                  child: AppLottie.loader.build(repeat: true),
                ),
              ),
            ),
          ],
        ),
      )
          : Container();
    });
  }
}
