import 'package:get/get.dart';

import 'signupcontroller.dart';

class SingupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupController>(
          () => SignupController(),
    );
  }
}