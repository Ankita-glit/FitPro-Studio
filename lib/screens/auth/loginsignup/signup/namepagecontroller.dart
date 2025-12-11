import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstdayappsuccessor/screens/auth/loginsignup/login/loginmodel.dart';
import 'package:firstdayappsuccessor/screens/auth/loginsignup/signup/gender/gendercontroller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'gender/genderview.dart';

class NamePageController extends GetxController{

  TextEditingController nametext = TextEditingController();
  Loginmodel loginmodel = Loginmodel();
  final Dio dio = Dio();
  String userid = FirebaseAuth.instance.currentUser?.uid??'';
  RxBool isLoading = false.obs;

  Future<void> UpdateName(String userId) async {
    isLoading.value=true;
    try {
      dio.options = BaseOptions(
        validateStatus: (status) {
          return status! < 500;
        },
      );

      final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.none) {
        isLoading.value = false;
        Get.snackbar('Error', 'No internet connection. Please check your connection.',
            backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
        return;
      } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
        isLoading.value = false;
        Get.snackbar('Alert', 'Internet connection is slow. Please wait for a better connection.',
            backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
      }
      final url = 'https://fitarcbe.boostproductivity.online/api/v1/user/$userId/';
      print('Making PATCH request to: $url');

      final data = {
        'name': nametext.text,
      };

      final response = await dio.patch(url, data: data);

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        var responseData = response.data;
        isLoading.value=false;

        if (responseData is Map<String, dynamic>) {
          loginmodel = Loginmodel.fromJson(responseData);

          if (loginmodel.name == null || loginmodel.name!.isEmpty) {
            loginmodel.name = nametext.text;
          }

          print("User Found: ${loginmodel.name}, ${loginmodel.email}");

          print('Routing to Genderview with name: ${nametext.text}');
          Get.put(GenderController());
          Get.to(Genderview(), arguments: loginmodel,transition: Transition.fadeIn);

        } else {
          isLoading.value=false;
          Get.snackbar('Error', 'Invalid response format.',
              backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
        }
      } else if (response.statusCode == 404) {
        isLoading.value = false;
        print('Status code 404 - User not found on the server');
      } else {
        isLoading.value = false;
        Get.snackbar('Error',
            'Unexpected error occurred. Status code: ${response.statusCode}',
            backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value=false;
          print("catch is $e");
    }
  }}