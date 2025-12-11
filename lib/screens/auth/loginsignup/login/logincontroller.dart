import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstdayappsuccessor/screens/auth/loginsignup/login/loginmodel.dart';
import 'package:firstdayappsuccessor/screens/auth/loginsignup/signup/namepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../helper/firebaseauth.dart';
import '../../../../helper/sharedprefrence/storedatashared.dart';
import '../../../bottomnavbar/bottomnavbarview.dart';

class Logincontroller extends GetxController{

  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  RxBool isOpen = false.obs;
  final FirebaseAuthService _auth = FirebaseAuthService();
  String? userid;
  String? useridgoogle;
  RxBool isLoading = false.obs;
  final Dio dio = Dio();
  Loginmodel loginmodel = Loginmodel();

  void signIn() async {
    isLoading.value=true;
    String email = emailcontroller.text;
    String password = passwordcontroller.text;
    if (email.isEmpty || password.isEmpty) {
      isLoading.value = false;
      Get.snackbar('Alert', 'Please Enter the Email and Password',
          backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
      return;
    }
    User? user = await _auth.signInWithEmailAndPassword(email, password);
    userid = FirebaseAuth.instance.currentUser?.uid ?? '';
    print(userid);
    final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      isLoading.value=false;
      Get.snackbar('Error', 'No internet connection. Please check your connection.',
          backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
      return;
    } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      isLoading.value=false;
      Get.snackbar('Alert', 'Internet connection is slow. Please wait for a better connection.',
          backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
    }

    if (user != null) {
      await getUser(userid!);

    } else {
      isLoading.value=false;
      Get.snackbar('Alert', 'Please Enter valid email and password',
          backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
    }
  }

  googleLogin() async {
    print("googleLogin method Called");

    GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      isLoading.value = true;

      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        isLoading.value = false;
        Get.snackbar("Login Failed", "Google Sign-In was canceled.",
            backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);

      User? user = userCredential.user;

      if (user != null) {
        useridgoogle = FirebaseAuth.instance.currentUser!.uid ?? '';
        await getUser(useridgoogle!);
        print("Google User Signed In: ${user.displayName}");
      } else {
        isLoading.value = false;  // Stop loading if sign-in failed
        Get.snackbar('Error', 'Failed to sign in with Google.',
            backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
      }
    } catch (error) {
      print("Google Sign-In Error: $error");
      isLoading.value = false;
      Get.snackbar('Error', 'An error occurred during Google login.',
          backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
    }
  }

  Future<void> getUser(String userId) async {
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
          loginmodel = Loginmodel.fromJson(responseData);
          await saveUserData(loginmodel);
          print("User Found: ${loginmodel.name}, ${loginmodel.email}");
          Get.offAll(Bottomnavbarview());
          isLoading.value=false;
          print("User is Successfully Login");
          Get.snackbar('Success', 'User is successfully Login',
              backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
        }
      } else if (response.statusCode == 404) {
        CreateUser(userId);
      } else {
        isLoading.value=false;
        Get.snackbar('Error', 'Unexpected error occurred. Status code: ${response.statusCode}',
            backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
      }
    } catch (e) {
      isLoading.value=false;
        print('Error during API call: $e');
        Get.snackbar('Error', 'An error occurred while checking user status.',
            backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
      }
  }

  Future<void> CreateUser(String userId) async{
    try{
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
      final response = await dio.post(url,data: data);
      if(response.statusCode==201){
        isLoading.value=false;
        Get.to(Namepage(),transition: Transition.fadeIn);
      }else{
        isLoading.value=false;
        if(response.statusCode==400){
          await saveUserData(loginmodel);
          isLoading.value=false;
          Get.snackbar(
            'Alert',
            'Email already exist. Please Login',
            backgroundColor: Color(0xff2F2F2F),
            colorText: Colors.white,
          );
        }
      }
    }catch(e){
       print(e);
       isLoading.value=false;
    }
  }
  @override
  void onClose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    super.onClose();
  }
}
