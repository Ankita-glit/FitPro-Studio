import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstdayappsuccessor/screens/home/homescreencontroller.dart';
import 'package:firstdayappsuccessor/screens/pushpage/reps/exercisecompleteondatemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../app_route/app_pages.dart';
import '../../home/homescreenmodel.dart';
import '../pushpagecontroller.dart';
import '../repsweight/completeexercisemodel.dart';

class NextScreenController extends GetxController {

  Homescreencontroller pushcontroller = Get.put(Homescreencontroller());
  var currentSetIndex = 0.obs;
  var isStarted = false.obs;
  var weightEnteredList = <RxBool>[];
  PushupController control = Get.put(PushupController());
  var name = '';
  String eximage = '';
  String image='';
  bool isweighted = false;
  var repsList = <String>[];
  var weightList = <String>[];
  String category = '';
  var weightcontroller = <TextEditingController>[];
  var repsController = <TextEditingController>[];
  var isCompleted = false.obs;
  String? exType;
  int count = 3;
  var datas = Rxn<Datum>();
  var data = Rxn<Datum>();
  ExerciseModel exerciseModel = ExerciseModel();
  Datum? categoryData;
  int? typecategoryindex;
  int ? exerciseId;
  String? fullimages;
  final Dio dio = Dio();
  String? formattedDate;
  String? gender;
  var categories;
  List<CompleteExerciseModel>? completeExerciseModel;
  List<String> getWeightData() {
    return weightcontroller.map((controller) => controller.text).toList();
  }
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final box = GetStorage();
    var storedCategory = box.read("selectedCategory");

    print("DEBUG: Stored category data: $storedCategory");

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      var args = Get.arguments as Map<String, dynamic>;
      if (args.containsKey('name')) name = args['name'];
      if (args.containsKey('eximage')) eximage = args['eximage'];
      if(args.containsKey('image')) image = args['image'];
      if(args.containsKey('gender')) gender = args['gender'];
      if(args.containsKey('exType')) exType = args['exType'];
      if(args.containsKey('id')) exerciseId = args['id'];
      if (args.containsKey('category')) category = args['category'];
      if(args.containsKey('categories')) categories = args['categories'];
      if(args.containsKey('count')) count= args['count'];
      print(count);

      print("Extracted Arguments: Name: $name, Image: $image, RepsList: $repsList");
      fullimages=getFullExerciseImage(eximage,gender!);
      if (args.containsKey('categoryData') && args['categoryData'] is Datum) {
        categoryData = args['categoryData'] as Datum;
        print("Retrieved categoryData: ${categoryData?.categoryName!}");
      }
    }

    if (Get.arguments != null && Get.arguments.containsKey('datum') && Get.arguments['datum'] is Map<String, dynamic>) {
      datas.value = Datum.fromJson(Get.arguments['datum']);
      print("Retrieved Datum from arguments: ${datas.value!.categoryName}");
    }
    else if (storedCategory != null) {
      try {
        datas.value = Datum.fromJson(storedCategory);
        print("Loaded Datum from Storage: ${datas.value!.categoryName}");
      } catch (e) {
        print("ERROR: Failed to parse Datum from GetStorage: $e");
      }
    }
    print("Final Values -> Name: $name, Image: $image, RepsList: $repsList");

    initializeWeightControllers(count);
  }

  String getFullExerciseImage(String exerciseImage, String gender) {
    String baseurl = "https://fitarcbe.boostproductivity.online";
    String trimmedImage = exerciseImage.substring(0, exerciseImage.length - 5);
    String fullimage = baseurl + trimmedImage + gender + ".webp";
    return fullimage;
  }

  void initializeWeightControllers(int count) {
    repsController = List.generate(count, (index) => TextEditingController(text: "10"));
    weightcontroller = List.generate(count, (index) => TextEditingController(text: ""));
    weightEnteredList = List.generate(count, (index) => false.obs);

    for (int i = 0; i < count - 1; i++) {
      weightcontroller[i].addListener(() {
        if (weightcontroller[i].text.isNotEmpty) {
          weightcontroller[i + 1].text = weightcontroller[i].text;
        }
      });
      repsController[i].addListener(() {
        if (repsController[i].text.isNotEmpty) {
          repsController[i + 1].text = repsController[i].text;
        }
      });
    }
  }

  void incrementWeight(int index, int increment) {
    double currentWeight = double.tryParse(weightcontroller[index].text) ?? 0.0;
    double newWeight = currentWeight + increment;
    weightcontroller[index].text = newWeight.toString();
    print("Updated weight for Set ${index + 1}: ${weightcontroller[index].text} kg");
  }

  Future<Uint8List> convertImageToBytes(String imagePath) async {
    File imageFile = File(imagePath);
    return await imageFile.readAsBytes();
  }
  bool isError = false;

  Future<void> saveWorkoutDataWithWeight() async {
    isLoading.value = true;
    List<String> weightList = weightcontroller.map((controller) => controller.text).toList();
    List<String> repsList = repsController.map((controller) => controller.text).toList();
    DateTime now = DateTime.now();
    formattedDate = "${now.year}-${now.month}-${now.day}";

    List<Map<String, dynamic>> repsData = List.generate(count, (index) {
      return {
        'set_serial': index + 1,
        'reps_count': int.tryParse(repsList[index]) ?? 0,
        'weight': double.tryParse(weightList[index]) ?? 0.0,
        'wunit': "Kg",
      };
    });

    Map<String, dynamic> workoutData = {
      'sets_count': count,
      'date': formattedDate,
      'reps': repsData,
    };
    String uid = FirebaseAuth.instance.currentUser!.uid ?? '';
    try {
      String baseurl = "https://fitarcbe.boostproductivity.online/api/v1/";
      final url = baseurl + "user/" + uid + "/exercise/" + "$exerciseId";
      print(url);
      dio.options = BaseOptions(
        validateStatus: (status) {
          return status! < 500;
        }
      );
      final response = await dio.post(url, data: workoutData);

      print(response.statusCode);
      if (response.statusCode == 201) {
        var responseData = response.data;
        if (responseData == true) {
          isError = false;
          Get.back();
          Get.back();
          Get.put(PushupController());
          control.targetBodyPartName.value = 'Your Exercises';
          isLoading.value = false;
          Get.offAndToNamed(Routes.PUSHUPVIEW, arguments: categories);
        }
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        isError = true;
        isLoading.value = false;
        int repsValue = int.tryParse(repsController[currentSetIndex.value].text) ?? 3;
        if (repsValue < 3) {
          Get.snackbar('Alert', 'Please enter reps value 3 or greater', backgroundColor: Color(0xff2F2F2F),
              colorText: Colors.white);
          return;
        }
        isLoading.value = false;
          Get.snackbar('Error',
              'Please check internet connection and proper data entry ${response
                  .statusCode}',
              backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);

      }
    } catch (e) {
      isLoading.value = false;
      print('Error during API call: $e');
      isError = true;
      Get.snackbar('Error', 'An error occurred while checking user status.',
          backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
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

  String getImagePath(NextScreenController controller) {
    String imagePath = "${controller.image}";
    return imagePath;
  }

  Widget ShowCompletedExercises(List<CompleteExerciseListOnDatemodel>? completeExerciseListOnDatemodel, String gender) {
    return ListView.builder(
      itemCount: completeExerciseListOnDatemodel?.length ?? 0,
      itemBuilder: (context, index) {
        var exercise = completeExerciseListOnDatemodel![index].exercise;
        return Container(
          margin: EdgeInsets.only(bottom: 10, left: 20, right: 20),
          width: Get.width,
          height: 53,
          decoration: BoxDecoration(
            color: Color(0xff2F2F2F),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildExerciseImage(exercise?.exImage ?? "", gender),
              SizedBox(width: 14),
              SizedBox(
                width: Get.width - 140,
                child: Text(
                  exercise?.exName ?? "No Name",
                  maxLines: 2,
                  softWrap: true,
                  style: TextStyle(
                    color: Color(0xffC4C4C4),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Instrument Sans',
                  )
                )
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Icon(Icons.cabin,
                  )
              )
            ]
          )
        );
      }
    );
  }


  Widget _buildExerciseImage(String exerciseImage,String gender) {
    String baseurl = "https://fitarcbe.boostproductivity.online";
    String trimmedImage = exerciseImage.substring(0, exerciseImage.length - 5);
    String fullimage = baseurl + trimmedImage + gender + ".webp";
    return Padding(
      padding: const EdgeInsets.only(left: 12.0),
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl: fullimage!,
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(child: Container(decoration: BoxDecoration(color: Colors.grey.shade50),)),
            errorWidget: (context, url, error) => Icon(Icons.error),
          )
        )
      )
    );
  }

  @override
  void onClose() {
    for (var controller in weightcontroller) {
      controller.dispose();
    }
    super.onClose();
    Get.delete<NextScreenController>();
  }
}

