import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Heightcontroller extends GetxController{

  TextEditingController weightcontroller = TextEditingController();
  var isCmSelected = true.obs;
  final Dio dio = Dio();
  final cmController = TextEditingController();
  final Ftcontroller = TextEditingController();
  final inchController = TextEditingController();
  String finalheight='';
  String userid = FirebaseAuth.instance.currentUser!.uid ?? '';
  RxBool isLoading = false.obs;

  @override
  void onInit(){
    super.onInit();
    loadSaveddata();
  }

  Future<void> loadSaveddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    int? storedHeight = prefs.getInt('user_height');
    String? storedHeightunit = prefs.getString('user_heightunit');

    if(storedHeight!=null){
      if(storedHeightunit!=null){
        if(storedHeightunit=="Cm"){
          cmController.text=storedHeight.toString();
        }else{
          double cm = storedHeight.toDouble();
          double totalInches = cm / 2.54;
          int feet = (totalInches / 12).floor();
          int inches = (totalInches % 12).round();
          Ftcontroller.text = feet.toString();
          inchController.text = inches.toString();
        }
      }
    }

  }

  Future<void> UpdateHeight() async {
    isLoading.value = true;
    try {
      dio.options = BaseOptions(
        validateStatus: (status) {
          return status! < 500;
        },
      );
      final url = 'https://fitarcbe.boostproductivity.online/api/v1/user/$userid/';

      final data = {
        "height": finalheight,
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