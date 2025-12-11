import 'package:firstdayappsuccessor/screens/pushpage/repsweight/repsweightcontroller.dart';
import 'package:get/get.dart';


class Repsweightbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Repsweightcontroller>(
          () => Repsweightcontroller(),
    );
  }
}