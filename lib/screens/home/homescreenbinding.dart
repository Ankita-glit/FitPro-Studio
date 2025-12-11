import 'package:firstdayappsuccessor/screens/auth/loginsignup/login/logincontroller.dart';
import 'package:firstdayappsuccessor/screens/home/homescreencontroller.dart';
import 'package:get/get.dart';


class Homescreenbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Homescreencontroller>(
          () => Homescreencontroller(),
    );
  }
}