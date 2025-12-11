import 'package:firstdayappsuccessor/screens/progressbar/progresscontroller.dart';
import 'package:get/get.dart';
class Progressbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProgressController>(
          () => ProgressController(),
    );
  }
}