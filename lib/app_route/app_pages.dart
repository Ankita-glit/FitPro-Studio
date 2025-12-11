
import 'package:firstdayappsuccessor/screens/auth/loginsignup/login/loginbinding.dart';
import 'package:firstdayappsuccessor/screens/auth/loginsignup/login/loginview.dart';
import 'package:firstdayappsuccessor/screens/home/homescreenview.dart';
import 'package:firstdayappsuccessor/screens/progressbar/progresscategory/progresscategorybindings.dart';
import 'package:firstdayappsuccessor/screens/progressbar/progresscategory/progresscategoryview.dart';
import 'package:firstdayappsuccessor/screens/progressbar/progresscategory/progressdetails/progressdetailsbindings.dart';
import 'package:firstdayappsuccessor/screens/progressbar/progresscategory/progressdetails/progressdetailsview.dart';
import 'package:firstdayappsuccessor/screens/pushpage/reps/repsbinding.dart';
import 'package:firstdayappsuccessor/screens/pushpage/reps/repsview.dart';
import 'package:firstdayappsuccessor/screens/pushpage/repsweight/repsweightbinding.dart';
import 'package:firstdayappsuccessor/screens/pushpage/repsweight/repsweightview.dart';
import 'package:firstdayappsuccessor/screens/splash/splashview.dart';
import 'package:get/get.dart';

import '../screens/auth/forgotpassword/resetpassview.dart';
import '../screens/auth/forgotpassword/resetpasswordbinding.dart';
import '../screens/auth/loginsignup/signup/signupbinding.dart';
import '../screens/auth/loginsignup/signup/signupview.dart';
import '../screens/home/homescreenbinding.dart';
import '../screens/pushpage/pushpagebinding.dart';
import '../screens/pushpage/pushpageview.dart';
import '../screens/splash/splashbinding.dart';

part 'app_routes.dart';

class AppPages{
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
        name: _Paths.SPLASH,
        page: ()=> Splashview(),
      binding: SplashBinding(),
      transition: Transition.fadeIn
    ),
    GetPage(
        name: _Paths.SIGNUP,
        page: ()=> SignupView(),
        binding: SingupBinding(),
        transition: Transition.fadeIn
    ),

    GetPage(
        name: _Paths.LOGIN,
        page: ()=> Loginview(),
        binding: Loginbinding(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: _Paths.RESETPASSWORD,
        page: ()=> Resetpassview(),
        binding: Resetpasswordbinding(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: _Paths.HOME,
        page: ()=> Homescreenview(),
        binding: Homescreenbinding(),
        transition: Transition.leftToRight
    ),
    GetPage(
        name: _Paths.PUSHUPVIEW,
        page: ()=> Pushpageview(),
        binding: Pushpagebinding(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: _Paths.REPS,
        page: ()=> Repsview(),
        binding: Repsbinding(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: _Paths.REPSWEIGHT,
        page: ()=> Repsweightview(),
        binding: Repsweightbinding(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: _Paths.PROGRESSCATEGORY,
        page: ()=> Progresscategoryview(),
        binding: Progresscategorybindings(),
        transition: Transition.fadeIn
    ),
    GetPage(
        name: _Paths.PROGRESSDETAILSPAGE,
        page: ()=> Progressdetailsview(),
        binding: Progressdetailsbindings(),
        transition: Transition.fadeIn
    ),
  ];
}