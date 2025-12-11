import 'package:firstdayappsuccessor/screens/auth/forgotpassword/resetpasscontroller.dart';
import 'package:get/get.dart';

class Resetpasswordbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(
          () => ResetPasswordController(),
    );
  }
}