import 'package:flutter/material.dart';
import 'package:get/get.dart';
Widget buildBackButton() {
  return Container(
    height: 57,
    width: 57,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: Color(0xff2F2F2F).withOpacity(0.88),
    ),
    child: Icon(
      Icons.arrow_back_ios_new,
      color: Colors.white,
      size: 20,
    ),
  );
}