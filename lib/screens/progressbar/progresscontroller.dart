import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../helper/calendercontroller.dart';
import '../pushpage/pushuppagerepo.dart';
import '../pushpage/reps/exercisecompleteondatemodel.dart';

class ProgressController extends GetxController {
  CalendarController controller = Get.put(CalendarController());
  var formattedDate;
  RxList<Exercise> pushExercises = <Exercise>[].obs;
  RxList<Exercise> pullExercises =  <Exercise>[].obs;
  RxList<Exercise> legsExercises =  <Exercise>[].obs;
  List<CompleteExerciseListOnDatemodel>? newCompletedExercises;
  String? selectedDate;
  var hasAnyExercises = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Listen to selected date changes
    ever(controller.selectedDay, (_) {
      FetchCompletedExerciseListOnDate();
    });

    // Initial fetch for today’s date
    FetchCompletedExerciseListOnDate();
  }


  List<List<Exercise>> categorizeExercises(List<CompleteExerciseListOnDatemodel> exerciseList) {
    pushExercises.clear();
    pullExercises.clear();
    legsExercises.clear();
    for (var data in exerciseList) {
      final exercise = data.exercise;
      if (exercise != null && exercise.exCategories != null) {
        for (var category in exercise.exCategories!) {
          final name = category.name?.toLowerCase();
          if (name == 'push') pushExercises.add(exercise);
          if (name == 'pull') pullExercises.add(exercise);
          if (name == 'legs') legsExercises.add(exercise);
        }
      }
    }

    hasAnyExercises.value = pushExercises.isNotEmpty || pullExercises.isNotEmpty || legsExercises.isNotEmpty;
    return [pushExercises, pullExercises, legsExercises];
  }

  Future<void> FetchCompletedExerciseListOnDate() async {
    pushExercises.clear();
    pullExercises.clear();
    legsExercises.clear();
    hasAnyExercises.value = false;
    DateTime now = DateTime.now();
    formattedDate = "${now.year}-${now.month}-${now.day}";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedName = prefs.getString('user_gender');
    // gender = storedName;
    String uid = FirebaseAuth.instance.currentUser!.uid ?? '';

    String baseurl = "https://fitarcbe.boostproductivity.online/api/v1/";
    selectedDate = controller.selectedDay.value != null
        ? DateFormat('yyyy-MM-dd').format(controller.selectedDay.value)
        : formattedDate;
    String url = baseurl + "user/" + uid + "/exercises/" +selectedDate!+"/";
    print(url);

    try {
      PushupPageRepo().CompleteExerciseListOnTimeRepo(
        beforeSend: () {},
        url: url,
        onSuccess: (data) {
          if (data.isSuccess) {
            newCompletedExercises = data.resObject!;
            categorizeExercises(newCompletedExercises!);
          }
        },
        onError: (error) {
          print(error);
          Get.snackbar("Alert", "Please Enter Valid data ${error}");
        },
      );
    } catch (error) {
      print(error);
      Get.snackbar("Alert", "Please Enter Valid data ${error}");
    }
  }
  String? fullimage;
  String? image;

  String fetchImagePush(String title) {
    if(title=='PUSH') {
      if (pushExercises.isNotEmpty &&
          pushExercises.first.exCategories != null &&
          pushExercises.first.exCategories!.isNotEmpty) {
        String baseurl = "https://fitarcbe.boostproductivity.online";

        var image = pushExercises.first.exCategories!.first.image;

        if (image != null) {
          print(baseurl + image);
          return baseurl + image;
        }
      }
      return '';
    }
    if(title=='PULL') {
      if (pullExercises.isNotEmpty &&
          pullExercises.first.exCategories != null &&
          pullExercises.first.exCategories!.isNotEmpty) {
        String baseurl = "https://fitarcbe.boostproductivity.online";

        var image = pullExercises.first.exCategories!.first.image;

        if (image != null) {
          print(baseurl + image);
          return baseurl + image;
        }
      }
      return '';
    }
    if(title=='LEGS') {
      if (legsExercises.isNotEmpty && legsExercises.first.exCategories != null && legsExercises.first.exCategories!.isNotEmpty) {
        String baseurl = "https://fitarcbe.boostproductivity.online";

        var image = legsExercises.first.exCategories!.first.image;

        if (image != null) {
          print(baseurl+image);
          return baseurl + image;
        }
      }
      return '';
    }
    return '';
  }
  String fetchImagePull() {
    if (pullExercises.isNotEmpty && pullExercises.first.exCategories != null && pullExercises.first.exCategories!.isNotEmpty) {
      String baseurl = "https://fitarcbe.boostproductivity.online";

      var image = pullExercises.first.exCategories!.first.image;

      if (image != null) {
        print(baseurl+image);
        return baseurl + image;
      }
    }
    return '';
  }
  String fetchImageLegs() {
    if (legsExercises.isNotEmpty && legsExercises.first.exCategories != null && legsExercises.first.exCategories!.isNotEmpty) {
      String baseurl = "https://fitarcbe.boostproductivity.online";

      var image = legsExercises.first.exCategories!.first.image;

      if (image != null) {
        print(baseurl+image);
        return baseurl + image;
      }
    }
    return '';
  }
}
