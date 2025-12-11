import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:firstdayappsuccessor/screens/bottomnavbar/bottomnavbarview.dart';
import 'package:firstdayappsuccessor/screens/auth/loginsignup/signup/namepage.dart';
import '../../screens/auth/loginsignup/login/loginmodel.dart';
import 'package:flutter/material.dart';

class ApiHelper {
  static final Dio dio = Dio();
  static Future<void> getUser(String userId) async {
    try {
      dio.options = BaseOptions(
        validateStatus: (status) {
          return status! < 500;
        },
      );

      final url = 'https://fitarcbe.boostproductivity.online/api/v1/user/$userId';
      print(url);
      final response = await dio.get(url);

      if (response.statusCode == 200) {
        var responseData = response.data;

        if (responseData is Map<String, dynamic>) {
          Loginmodel loginmodel = Loginmodel.fromJson(responseData);

          print("User Found: ${loginmodel.name}, ${loginmodel.email}");
          Get.offAll(Bottomnavbarview());
        }
      } else if (response.statusCode == 404) {
        CreateUser(userId);
      } else {
        Get.snackbar(
          'Error',
          'Unexpected error occurred. Status code: ${response.statusCode}',
          backgroundColor: Color(0xff2F2F2F),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error during API call: $e');
      Get.snackbar(
        'Error',
        'An error occurred while checking user status.',
        backgroundColor: Color(0xff2F2F2F),
        colorText: Colors.white,
      );
    }
  }

  static Future<void> CreateUser(String userId) async {
    try {
      dio.options = BaseOptions(
        validateStatus: (status) {
          return status! < 500;
        },
      );

      final url = 'https://fitarcbe.boostproductivity.online/api/v1/user/$userId/';
      print(url);

      String email = FirebaseAuth.instance.currentUser!.email ?? '';
      print(email);

      final data = {"email": email};
      final response = await dio.post(url, data: data);

      if (response.statusCode == 201) {
        Get.to(Namepage());
      } else if (response.statusCode == 400) {
        Get.to(Bottomnavbarview());
      }
    } catch (e) {
      print('Error during user creation: $e');
    }
  }
}
