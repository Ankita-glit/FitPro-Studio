import 'package:firstdayappsuccessor/screens/auth/loginsignup/login/logincontroller.dart';
import 'package:get/get.dart';


class Loginbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Logincontroller>(
          () => Logincontroller(),
    );
  }
}