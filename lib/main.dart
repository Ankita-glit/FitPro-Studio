import 'package:firebase_core/firebase_core.dart';
import 'package:firstdayappsuccessor/screens/auth/loginsignup/login/loginmodel.dart';
import 'package:firstdayappsuccessor/screens/progressbar/progresscontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app_route/app_pages.dart';
import 'package:get_storage/get_storage.dart';
import 'helper/calendercontroller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Loginmodel? loginmodel;
  Get.put(CalendarController());
  Get.put(ProgressController());
  Get.put(ProgressController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Fitness App",
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      debugShowCheckedModeBanner: false,
    theme: ThemeData(
    primarySwatch: Colors.blue,
    textSelectionTheme: TextSelectionThemeData(
    cursorColor: Color(0xffCFED51),
    selectionColor: Color(0xffCFED51).withOpacity(0.4),
    selectionHandleColor: Color(0xffCFED51),
    ),),
      initialRoute: Routes.SPLASH,
      getPages: AppPages.routes,
    );
  }
}
