import 'package:firstdayappsuccessor/screens/pushpage/pushpagecontroller.dart';
import 'package:get/get.dart';


class Pushpagebinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PushupController>(
          () => PushupController(),
    );
  }
}