import 'package:firstdayappsuccessor/screens/pushpage/reps/repscontroller.dart';
import 'package:get/get.dart';

class Repsbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Repscontroller>(
          () => Repscontroller(),
    );
  }
}