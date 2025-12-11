import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstdayappsuccessor/helper/firebaseauth.dart';
import 'package:firstdayappsuccessor/helper/sharedprefrence/storedatashared.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../bottomnavbar/bottomnavbarview.dart';
import '../login/loginmodel.dart';
import 'namepage.dart';

class SignupController extends GetxController {

   TextEditingController emailController = TextEditingController();
   TextEditingController passwordController = TextEditingController();
   RxBool isOpen = false.obs;
   final Dio dio = Dio();
   Loginmodel loginmodel = Loginmodel();
   final FirebaseAuthService _auth = FirebaseAuthService();
   RxBool issignuploader = false.obs;

   void signUp() async {
      issignuploader.value = true;
      String email = emailController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
         issignuploader.value = false;
         Get.snackbar('Error', 'Email and password cannot be empty',
             backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
         return;
      }

      if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$").hasMatch(email)) {
         issignuploader.value = false;
         Get.snackbar('Error', 'Please enter a valid email address.',
             backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
         return;
      }

      if (password.length < 6) {
         issignuploader.value = false;
         Get.snackbar('Error', 'Password must be at least 6 characters.',
             backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
         return;
      }

      final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.none) {
         issignuploader.value = false;
         Get.snackbar('Error', 'No internet connection. Please check your connection.',
             backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
         return;
      } else if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
         issignuploader.value = false;
         Get.snackbar('Alert', 'Internet connection is slow. Please wait for a better connection.',
             backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
      }

      try {
         UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password
         );
         User? user = userCredential.user;

         if (user != null) {
            print("Firebase User is successfully created.");
            String userid = user.uid;
            await getUser(userid);
            issignuploader.value=false;
         } else {
            issignuploader.value = false;
            Get.snackbar('Error', 'Some error occurred. Please try again.',
                backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
         }
      } catch (e) {
         issignuploader.value = false;
         print("Error during sign up: $e");
         Get.snackbar('Alert', '${e.toString()}',
             backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
      }
   }

   googleSignup() async {
      print("googleLogin method Called");

      GoogleSignIn _googleSignIn = GoogleSignIn();
      try {
         issignuploader.value = true;
         await _googleSignIn.signOut();
         final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

         if (googleUser == null) {
            issignuploader.value = false;
            Get.snackbar("Login Failed", "Google Sign-In was canceled.", backgroundColor: Color(0xff2F2F2F), colorText: Colors.white,);
            return;
         }

         final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

         final OAuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
         );
         UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

         User? user = userCredential.user;
         String useridgoogle = FirebaseAuth.instance.currentUser!.uid ?? '';
         if (user != null) {
            print("Google User Signed In: ${user.displayName}");
            Get.snackbar('Success', 'Successfully signed in with Google!', backgroundColor: Color(0xff2F2F2F), colorText: Colors.white,);
            await getUser(useridgoogle);
         } else {
            issignuploader.value = false;
            Get.snackbar('Error', 'Failed to sign in with Google.', backgroundColor: Color(0xff2F2F2F), colorText: Colors.white,);
         }
      } catch (error) {
         issignuploader.value = false;
         print("Google Sign-In Error: $error");
         Get.snackbar('Error', 'An error occurred during Google login.', backgroundColor: Color(0xff2F2F2F), colorText: Colors.white,);
      }
   }

   Future<void> getUser(String userId) async {
      try {
         final url = 'https://fitarcbe.boostproductivity.online/api/v1/user/$userId';
         print(url);
         dio.options = BaseOptions(
            validateStatus: (status) {
               return status! < 500;
            },
         );
         final response = await dio.get(url);

         print(response.statusCode);
         if (response.statusCode == 200) {

            var responseData = response.data;

            if (responseData is Map<String, dynamic>) {
               loginmodel = Loginmodel.fromJson(responseData);
               await saveUserData(loginmodel);
               print("User Found: ${loginmodel.name}, ${loginmodel.email}");
               issignuploader.value = false;
               Get.offAll(Bottomnavbarview(),transition: Transition.fadeIn);
            } else {
               issignuploader.value = false;
               Get.snackbar('Error', 'Invalid response format.',
                   backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
            }
         } else if (response.statusCode == 404) {
            CreateUser(userId);
         } else {
            issignuploader.value = false;
            Get.snackbar('Error', 'Unexpected error occurred. Status code: ${response.statusCode}',
                backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
         }
      } catch (e) {
         issignuploader.value = false;
         print('Error during API call: $e');
         Get.snackbar('Error', 'An error occurred while checking user status.',
             backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
      }
   }

   Future<void> CreateUser(String userId) async {
      try {
         final url = 'https://fitarcbe.boostproductivity.online/api/v1/user/$userId/';
         print(url);
         dio.options = BaseOptions(
            validateStatus: (status) {
               return status! < 500;
            },
         );
         String email = FirebaseAuth.instance.currentUser!.email ?? '';
         print(email);
         final data = {'email': email};
         final response = await dio.post(url, data: data);
         if (response.statusCode == 201) {
            issignuploader.value = false;
            Get.to(Namepage(),transition: Transition.fadeIn);
         } else {
            if (response.statusCode == 400) {
               issignuploader.value = false;
               Get.snackbar(
                  'Alert',
                  'Email already exist. Please Login',
                  backgroundColor: Color(0xff2F2F2F),
                  colorText: Colors.white,
               );
            }
         }
      } catch (e) {
         issignuploader.value = false;
         print(e);
      }
   }

   @override
   void onClose() {
      emailController.dispose();
      passwordController.dispose();
      super.onClose();
   }
}

