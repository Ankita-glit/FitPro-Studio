import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstdayappsuccessor/screens/auth/loginsignup/login/loginmodel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../app_route/app_pages.dart';
import '../../helper/alertdialog/alertdialog.dart';

class ProfileController extends GetxController{
  RxBool isReminderEnabled = false.obs;
  String url = "https://sites.google.com/view/fitarc-privacypolicy-/home";
  final Dio dio = Dio();
  final userid = FirebaseAuth.instance.currentUser?.uid??'';
  Loginmodel? loginmodel;
  RxBool isLoading = false.obs;

  Future<void> LaunchUrl() async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> DeleteAccount(BuildContext context) async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        try {
          await user.delete();
          print('Firebase user deleted');

          await _deleteServerSideAccount();

          Get.offAllNamed(Routes.LOGIN);
        } on FirebaseAuthException catch (e) {
          if (e.code == 'requires-recent-login') {
            await CustomAlertDialog.showPresenceAlertL(
                message: "For security reasons, please log out and log back in before deleting your account.",
                confirmText: "Logout & login",
                cancelText: "CANCEL",
                context: context,
                onCancel: () => Get.back(),
                onConfirm: () {
                  Get.back();
                  FirebaseAuth.instance.signOut();
                  SharedPreferences.getInstance().then((prefs) {
                    prefs.clear();
                    Get.offAllNamed(Routes.LOGIN);
                  });
                }
            );
            return;
          } else {
            throw e;
          }
        }
      } else {
        Get.snackbar('Error', 'No Firebase user found.',
            backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
        return;
      }
    } catch (e) {
      print('Unexpected error: $e');
      Get.snackbar('Error', 'Something went wrong: $e',
          backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
    }
  }

  Future<void> _deleteServerSideAccount() async {
    try {
      dio.options = BaseOptions(
        validateStatus: (status) => status! < 500,
      );

      SharedPreferences prefs = await SharedPreferences.getInstance();
      final url = 'https://fitarcbe.boostproductivity.online/api/v1/user/$userid/';
      print('Making DELETE request to: $url');

      final response = await dio.delete(url);
      print('Response status: ${response.statusCode}');

      if (response.statusCode == 204) {
        await prefs.clear();
        Get.snackbar('Success!', 'Account is successfully deleted!',
            backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
      } else if (response.statusCode == 404) {
        print('No account present on the server');
        Get.snackbar('Error', 'No account found on the server.',
            backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
      } else {
        Get.snackbar('Error', 'Unexpected error occurred. Status code: ${response.statusCode}',
            backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
      }
    } catch (e) {
      print('Server-side deletion failed: $e');
      Get.snackbar('Error', 'Server-side deletion failed: $e',
          backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
    }
  }
}