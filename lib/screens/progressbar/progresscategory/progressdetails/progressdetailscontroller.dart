import 'package:get/get.dart';
import '../../../pushpage/reps/exercisecompleteondatemodel.dart';

class ProgressdetailsController extends GetxController{
String? exname;
String? eximage;
List<Rep>? reps;
String? fullimage;
String? gender;

  void onInit(){
    final args = Get.arguments as Map<String, dynamic>;
    exname=args['exname'];
    eximage=args['eximage'];
    reps=args['reps'];
    gender = args['gender'];
    fullimage = getFullExerciseImage(eximage!, gender!);
    super.onInit();
  }

String getFullExerciseImage(String exerciseImage, String gender) {
  String baseurl = "https://fitarcbe.boostproductivity.online";
  String trimmedImage = exerciseImage.substring(0, exerciseImage.length - 5);
  String fullimage = baseurl + trimmedImage + gender + ".webp";
  return fullimage;
}
}