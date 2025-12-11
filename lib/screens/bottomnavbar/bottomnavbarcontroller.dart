import 'package:firstdayappsuccessor/screens/auth/loginsignup/login/loginmodel.dart';
import 'package:firstdayappsuccessor/screens/auth/loginsignup/signup/gender/gendercontroller.dart';
import 'package:get/get.dart';
class Bottomnavbarcontroller extends GetxController {
  var currentIndex = 0.obs;
  GenderController controller = Get.put(GenderController());

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
