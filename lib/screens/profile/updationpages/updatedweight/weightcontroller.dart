import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WeightController extends GetxController{
  String userid = FirebaseAuth.instance.currentUser!.uid ?? '';
  TextEditingController weightcontroller = TextEditingController();
  Dio dio = Dio();
  RxBool isLoading = false.obs;

  void onInit(){
    super.onInit();
    loadSaveddata();
  }

  Future<void> loadSaveddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    double? storedWeight = prefs.getDouble('user_weight');

    if(storedWeight!=null){
      weightcontroller.text=storedWeight.toString();
      print(weightcontroller.text);
    }

  }
  Future<void> UpdateWeight() async {
    isLoading.value = true;
    try {
      dio.options = BaseOptions(
        validateStatus: (status) {
          return status! < 500;
        },
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final url = 'https://fitarcbe.boostproductivity.online/api/v1/user/$userid/';
      print('Making PATCH request to: $url');

      final data = {
        "weight": weightcontroller.text,
      };

      final response = await dio.patch(url, data: data);

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        var responseData = response.data;

        if (responseData is Map<String, dynamic>) {
          isLoading.value = false;
          Get.back();
        } else {
          isLoading.value = false;
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
      isLoading.value = false;
      print('Error: $e');
    }
  }
}