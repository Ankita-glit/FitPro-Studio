import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstdayappsuccessor/screens/home/homescreenmodel.dart';
import 'package:firstdayappsuccessor/screens/pushpage/repsweight/completeexercisemodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../app_route/app_pages.dart';
import '../pushpagecontroller.dart';
import '../pushuppagerepo.dart';
import '../reps/exercisecompleteondatemodel.dart';

class Repsweightcontroller extends GetxController {

  PushupController control = Get.put(PushupController());
  var currentSetIndex = 0.obs;
  var isStarted = false.obs;
  var name = '';
  String eximage='';
  String category='';
  late List<String> repsList;
  ExerciseModel exerciseModel = ExerciseModel();
  var repsController = <TextEditingController>[];
  var isCompleted = false.obs;
  String? type='';
  int count = 3;
  int? typecategoryindex;
  String? exType;
  int? exerciseId;
  String? gender;
  final Dio dio = Dio();
  String? formattedDate;
  String? fullimages;
  var categories;
  bool isError = false;
  List<CompleteExerciseModel>? completeExerciseModel;
  List<CompleteExerciseListOnDatemodel>? completeExerciseListOnDatemodel;

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments as Map<String, dynamic>;
    exerciseId=args['id']??'';
    name = args['name'] ?? '';
    eximage=args['eximage']??'assets/images/push.png';
    category=args['category']??'Nocategory';
    exType = args['exType']??'';
    count = args['count']??'';
    gender = args['gender']??'Male';
    categories = args['categories'] ??'';
    fullimages=getFullExerciseImage(eximage,gender!);
    initializeWeightControllers(count);
  }

  void initializeWeightControllers(int count) {
    repsController = List.generate(count, (index) => TextEditingController(text: "10"));
    for (int i = 0; i < count - 1; i++) {
      repsController[i].addListener(() {
        if (repsController[i].text.isNotEmpty) {
          repsController[i + 1].text = repsController[i].text;
        }
      });
    }
  }

  void startSet() {
    isStarted.value = true;
    if (currentSetIndex.value == count - 1) {
      isCompleted.value = true;
    }
  }

  void stopSet() {
    isStarted.value = false;
    if (currentSetIndex.value < count - 1) {
      currentSetIndex.value++;
    }
  }

  void previousSet() {
    if (currentSetIndex.value > 0) {
      currentSetIndex.value--;
      isStarted.value = false;
    }
  }

  String getFullExerciseImage(String exerciseImage, String gender) {
    String baseurl = "https://fitarcbe.boostproductivity.online";
    String trimmedImage = exerciseImage.substring(0, exerciseImage.length - 5);
    String fullimage = baseurl + trimmedImage + gender + ".webp";
    return fullimage;
  }

  Future<void> saveWorkoutDataWithWeight() async {
    if (repsController[currentSetIndex.value].text.isEmpty) {
      Get.snackbar('Missing', 'Please Enter Reps value');
      return;
    }

    List<String> repsList = repsController.map((controller) => controller.text).toList();
    DateTime now = DateTime.now();
    formattedDate = "${now.year}-${now.month}-${now.day}";

    List<Map<String, dynamic>> repsData = List.generate(count, (index) {
      return {
        'set_serial': index + 1,
        'reps_count': int.tryParse(repsList[index]) ?? 3,
        'wunit': "Kg",
      };
    });

    Map<String, dynamic> workoutData = {
      'sets_count': count,
      'date': formattedDate,
      'reps': repsData,
    };

    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (uid.isEmpty) {
      Get.snackbar('Error', 'User not authenticated');
      return;
    }

    try {
      String baseUrl = "https://fitarcbe.boostproductivity.online/api/v1/";
      final url = "$baseUrl/user/$uid/exercise/$exerciseId";
      print(url);

      dio.options = BaseOptions(
        validateStatus: (status) {
          return status! < 500;
        },
      );

      final response = await dio.post(url, data: workoutData);
      print(response.statusCode);

      if (response.statusCode == 201) {
        var responseData = response.data;
        if (responseData == true) {
          isError = false;
          // Get.delete<PushupController>();
          Get.back();
          Get.back();
          Get.put(PushupController());
          Get.offAndToNamed(Routes.PUSHUPVIEW, arguments: categories);

        }
      } else if (response.statusCode == 400||response.statusCode == 404) {
        isError = true;
        int repsValue = int.tryParse(repsController[currentSetIndex.value].text) ?? 3;
        if (repsValue < 3) {
          Get.snackbar('Alert', 'Please enter reps value 3 or greater',
            backgroundColor: Color(0xff2F2F2F),
            colorText: Colors.white);
          return;
        }else{
        Get.snackbar(
          'Error',
          'Please check internet connection and proper data entry ${response.statusCode}',
          backgroundColor: Color(0xff2F2F2F),
          colorText: Colors.white,
        );}
      } else {
        Get.snackbar(
          'Error',
          'Failed with status code: ${response.statusCode}',
          backgroundColor: Color(0xff2F2F2F),
          colorText: Colors.white,
        );
      }
    } catch (e) {
      print('Error during API call: $e');
      isError=true;
      Get.snackbar(
        'Error',
        'An error occurred while checking user status.',
        backgroundColor: Color(0xff2F2F2F),
        colorText: Colors.white,
      );
    }
  }

  Future<void> FetchCompleteExercises() async {
    String uid = FirebaseAuth.instance.currentUser!.uid??'';
    String baseurl = "https://fitarcbe.boostproductivity.online/api/v1/";
    String url =baseurl+"user/"+uid+"/exercises/"+formattedDate!+"/category/"+"Push"+"/";
    print(formattedDate);
    try {
      PushupPageRepo().CompleteExerciseRepo(
        beforeSend: () {},
        url: url,
        onSuccess: (data) {
          if (data.isSuccess) {
            completeExerciseModel = data.resObject!;
            FetchCompletedExerciseListOnDate();
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

  Future<void> FetchCompletedExerciseListOnDate() async {
    String uid = FirebaseAuth.instance.currentUser!.uid??'';
    String baseurl = "https://fitarcbe.boostproductivity.online/api/v1/";
    String url =baseurl+"user/"+uid+"/exercises/"+formattedDate!+"/";
    print(formattedDate);
    print(url);
    try {
      PushupPageRepo().CompleteExerciseListOnTimeRepo(
        beforeSend: () {},
        url: url,
        onSuccess: (data) {
          if (data.isSuccess) {
            completeExerciseListOnDatemodel = data.resObject!;
            control.targetBodyPartName.value = 'Your Exercises';
            Get.offAndToNamed(Routes.PUSHUPVIEW, arguments: {
              'completedExercises': completeExerciseListOnDatemodel,
            });
            Get.snackbar(
              'Success',
              'Successfully completed Exercise',
              backgroundColor: Color(0xff2F2F2F),
              colorText: Colors.white,
            );
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

}
