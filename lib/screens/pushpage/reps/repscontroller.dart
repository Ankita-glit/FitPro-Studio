import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firstdayappsuccessor/screens/auth/loginsignup/signup/gender/gendercontroller.dart';
import 'package:firstdayappsuccessor/screens/pushpage/pushuppagemodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../home/homescreenmodel.dart';

class Repscontroller extends GetxController {
  final arguments = Get.arguments as Map<String, dynamic>;
  late String name;
  RxInt count = 1.obs;
  int? id = 1;
  String? category='';
  String? fullimage = '';
  String eximage = '';
  String image='';
  String? type='';
  bool? isWeighted;
  var repsControllers = <TextEditingController>[].obs;
  var exerciseRepsData = <String, List<String>>{}.obs;
  GenderController genderController = Get.put(GenderController());
  final box = GetStorage();
  TypeCategory? exercise;
  ExerciseModel? exerciseModel;
  String? exType;
  int? exerciseId;
  CategoryExerciseModel? categoryExerciseModel;
  String? gender;
  var categories;

  @override
  void onInit() {
    super.onInit();
    final arguments = Get.arguments as Map<String, dynamic>;
    name = arguments['name'] ?? 'No Name';
    exerciseId = arguments['id'] ?? 1;
    eximage = arguments['eximage'] ?? 'assets/images/push.png';
    image=arguments['image']??'';
    category=arguments['category']??"Push";
    categories = arguments['categories'];
    exType = arguments['exType'] ??'';
    gender = arguments['gender']??'Male';
    print(exType);
    fullimage = getFullExerciseImage(eximage, gender!);

    print("Exercise Type: $exType");
    addNewSet();
  }

  void addNewSet() {
    if (repsControllers.length < 3) {
      repsControllers.add(TextEditingController());
      repsControllers.refresh();
    }
  }

  void RemoveSet() {
    if (repsControllers.length > 1) {
      repsControllers.last.dispose();
      repsControllers.removeLast();
      repsControllers.refresh();
    }
  }

  void saveRepsData() {
    DateTime now = DateTime.now();
    String formattedDate = "${now.year}-${now.month}-${now.day}";

    List<String> repsList = repsControllers.map((c) => c.text).toList();

    Map<String, dynamic> exerciseData = {
      'name': name,
      'category': category,
      'type': type,
      'image': image,
      'sets': repsList.length,
      'reps': repsList,
      'date': formattedDate,
    };

    List<dynamic> storedData = box.read('workoutData') ?? [];

    storedData.add(exerciseData);

    box.write('workoutData', storedData);

    print("📌 DEBUG: Saved Data - ${jsonEncode(storedData)}");
  }

  void clearData() {
    repsControllers.clear();
    exerciseRepsData.clear();
    name = '';
    id = 0;
    category = '';
    image = '';
    type = '';
    isWeighted = false;
    repsControllers.refresh();
    exerciseRepsData.refresh();
  }

  String getImagePath(Repscontroller controller) {
    String imagePath = "assets/exercises/${controller.category}/${controller.type}/${controller.image}";
    return imagePath;
  }

  void disposeControllers() {
    for (var controller in repsControllers) {
      controller.dispose();
    }
    repsControllers.clear();
    repsControllers.refresh();
  }

  String getFullExerciseImage(String exerciseImage, String gender) {
    String baseurl = "https://fitarcbe.boostproductivity.online";
    String trimmedImage = exerciseImage.substring(0, exerciseImage.length - 5);
    String fullimage = baseurl + trimmedImage + gender + ".webp";
    return fullimage;
  }

  @override
  void onClose() {
    disposeControllers();
    clearData();
    super.onClose();
  }
}


