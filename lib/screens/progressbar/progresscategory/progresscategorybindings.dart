import 'package:firstdayappsuccessor/screens/progressbar/progresscategory/progresscategorycontroller.dart';
import 'package:get/get.dart';

class Progresscategorybindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProgresscategoryController>(
          () => ProgresscategoryController(),
    );
  }
}