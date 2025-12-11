import 'package:get/get.dart';
import 'package:flutter/material.dart';
Widget buildGradientOverlay() {
  return Positioned(
    top: 190,
    left: 0,
    right: 0,
    child: Container(
      width: Get.width,
      height: Get.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.9),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            spreadRadius: 80,
            blurRadius: 90,
            offset: Offset(0, 0),
          ),
        ],
      ),
    ),
  );
}