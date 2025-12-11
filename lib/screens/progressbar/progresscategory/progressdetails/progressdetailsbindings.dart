import 'package:firstdayappsuccessor/screens/progressbar/progresscategory/progressdetails/progressdetailscontroller.dart';
import 'package:get/get.dart';
class Progressdetailsbindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProgressdetailsController>(
          () => ProgressdetailsController(),
    );
  }
}