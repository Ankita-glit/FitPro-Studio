import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstdayappsuccessor/screens/auth/loginsignup/loginSignupview.dart';
import 'package:firstdayappsuccessor/screens/profile/getusermodel.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../helper/sharedprefrence/storedatashared.dart';
import '../auth/loginsignup/login/loginmodel.dart';
import '../auth/loginsignup/signup/namepage.dart';
import '../bottomnavbar/bottomnavbarview.dart';
import 'package:dio/dio.dart';

class SplashController extends GetxController {
  Getusermodel getusermodel = Getusermodel();
  final Dio dio = Dio();
  Loginmodel loginmodel = Loginmodel();

  Future<void> navigateToView(BuildContext context) async {
    Future.delayed(const Duration(seconds: 4), () async {
      User? user = FirebaseAuth.instance.currentUser;
      final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.none) {
        Get.snackbar('Error', 'No internet connection. Please check your connection.',
            backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
        return;
      } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        Get.snackbar('Alert', 'Internet connection is slow. Please wait for a better connection.',
            backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
      }

      if (user != null) {
        String? userid = user.uid ?? '';
        await getUser(userid);
      } else {
        Get.offAll(Loginsignupview(),transition: Transition.fadeIn);
      }
    });
  }

  Future<void> getUser(String userId) async {
    try {
      final url = 'https://fitarcbe.boostproductivity.online/api/v1/user/$userId/';
      print(url);
      dio.options = BaseOptions(
        validateStatus: (status) {
          return status! < 500;
        },
      );
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        var responseData = response.data;

        if (responseData is Map<String, dynamic>) {
          loginmodel = Loginmodel.fromJson(responseData);
          await saveUserData(loginmodel);
          print("User Found: ${loginmodel.name}, ${loginmodel.email}");
          Get.offAll(Bottomnavbarview());
        } else {
          Get.snackbar(
            'Error',
            'Invalid response format.',
            backgroundColor: Color(0xff2F2F2F),
            colorText: Colors.white,
          );
        }
      } else if (response.statusCode == 404) {
        print('User not created on the server.');
        CreateUser(userId);
      } else {
        Get.snackbar(
          'Error',
          'Unexpected error occurred.',
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

  Future<void> CreateUser(String userId) async {
    try {
      final url = 'https://fitarcbe.boostproductivity.online/api/v1/user/$userId/';
      print(url);
      String email = FirebaseAuth.instance.currentUser!.email ?? '';
      print(email);
      final data = {'email': email};
      final response = await dio.post(url, data: data);
      if (response.statusCode == 201) {
        Get.to(Namepage());
      } else {
        if(response.statusCode==400){
          print('user already exist $response');
          await saveUserData(loginmodel);
          Get.snackbar(
            'Alert',
            'Email already exist. Please Login',
            backgroundColor: Color(0xff2F2F2F),
            colorText: Colors.white,
          );
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
