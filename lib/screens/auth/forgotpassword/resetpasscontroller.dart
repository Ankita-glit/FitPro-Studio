import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstdayappsuccessor/screens/auth/forgotpassword/resetmessage/resetmessageview.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ResetPasswordController extends GetxController{
TextEditingController emailcontroller = TextEditingController();
RxBool isLoading = false.obs;

Future passwordReset() async{
  isLoading.value = true;
  String email = emailcontroller.text.trim();
  if(emailcontroller.text.isEmpty) {
    isLoading.value = false;
    Get.snackbar(
      'Alert', 'Please enter your email', backgroundColor: Color(0xff2F2F2F),
      colorText: Colors.white,);
  }
  else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$").hasMatch(email)) {
    isLoading.value=false;
    Get.snackbar('Error', 'Please enter a valid email address.',
        backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
    return;
  }
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    Get.to(Resetmessageview());
    Get.snackbar('Success', 'Successfully send mail',backgroundColor: Color(0xff2F2F2F),colorText: Colors.white);

  }catch(e){
    isLoading.value=false;
    print(e);
  }
}

@override
  void dispose() {
    // TODO: implement dispose
  emailcontroller..dispose();
    super.dispose();
  }
}