import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../pushpage/reps/exercisecompleteondatemodel.dart';

class ProgresscategoryController extends GetxController{

  List<CompleteExerciseListOnDatemodel>? newCompletedExercises;
  String? selectedCategory;
  String? selectedDay;
  RxList<String> bodyParts = <String>[].obs;
  RxString targetBodyPartName = ''.obs;
  RxList<CompleteExerciseListOnDatemodel> WeightedList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> BodyWeightedList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> chestWeightedList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> chestBodyWeightList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> shoulderWeightedList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> shoulderBodyWeightList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> tricepsWeightedList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> tricepsBodyWeightList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> backWeightedList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> backBodyWeightList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> pullbicepsWeightedList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> pullbicepsBodyWeightList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> legsbicepsWeightedList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> legsbicepsBodyWeightList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> forearmsWeightedList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> forearmsBodyWeightList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> pulllegsWeightedList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> pulllegsBodyWeightList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> legslegsWeightedList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> legslegsBodyWeightList = <CompleteExerciseListOnDatemodel>[].obs;
  String? gender;

  @override
  void onInit() {
    super.onInit();
    _initData();
  }

  Future<void> _initData() async {
    final args = Get.arguments as Map<String, dynamic>;

    newCompletedExercises = args['exercises']?.cast<CompleteExerciseListOnDatemodel>();
    selectedCategory = args['category'];
    selectedDay = args['completeddate'];

    print("Selected Category: $selectedCategory");
    print("Exercises Count: ${newCompletedExercises?.length}");
    print("Selected Day: $selectedDay");

    await loadSaveddata();

    setInitialBodyPart(selectedCategory!);
    extractBodyParts();

    if (newCompletedExercises != null) {
      fetchExercisesBasedOnBodyPart();
    }
  }

  Future<void> loadSaveddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedName = prefs.getString('user_gender');

    if (storedName != null && storedName.isNotEmpty) {
      gender = storedName;
      print("Gender Loaded: $gender");
    }
  }

  void extractBodyParts() {
    bodyParts.clear();

    Map<String, List<String>> categoryToBodyParts = {
      "push": ["Chest", "Shoulders", "Triceps"],
      "pull": ["Back", "Biceps", "Forearms"],
      "legs": ["Legs"],
    };

    for (var exercise in newCompletedExercises!) {
      final target = exercise.exercise?.targetBodyPart?.name;
      if (target != null &&
          categoryToBodyParts[selectedCategory]?.contains(target) == true &&
          !bodyParts.contains(target)) {
        bodyParts.add(target);
      }
    }

    final fallbackParts = categoryToBodyParts[selectedCategory] ?? [];
    for (var part in fallbackParts) {
      if (!bodyParts.contains(part)) {
        bodyParts.add(part);
      }
    }

    if (categoryToBodyParts.containsKey(selectedCategory)) {
      List<String> predefinedOrder = categoryToBodyParts[selectedCategory]!;
      bodyParts.sort((a, b) {
        return predefinedOrder.indexOf(a) - predefinedOrder.indexOf(b);
      });
    }
    print("Filtered body parts for $selectedCategory: $bodyParts");
  }

  void updateSelectedBodyPart(String bodyPart) {
    targetBodyPartName.value = bodyPart;
    fetchExercisesBasedOnBodyPart();
    update();
  }

  void fetchExercisesBasedOnBodyPart() {
    WeightedList.clear();
    BodyWeightedList.clear();
    _populateBodyPartLists();
    switch (targetBodyPartName.value) {
      case 'Chest':
        fetchChestExercises();
        break;
      case 'Shoulders':
        _fetchShoulderExercises();
        break;
      case 'Triceps':
        _fetchTricepsExercises();
        break;
      case 'Back':
        fetchBackExercises();
        break;
      case 'Biceps':
        fetchBicepsExercises();
        break;
      case 'Forearms':
        fetchForearmsExercises();
        break;
      case 'Legs':
        fetchLegsExercises();
        break;
      default:
        break;
    }

    update();
  }

  void _populateBodyPartLists() {
    for (var el in newCompletedExercises!) {
      void addToList(RxList<CompleteExerciseListOnDatemodel> list, CompleteExerciseListOnDatemodel item) {
        if(!list.any((e) => e.id == item.id)){
          list.add(item);
        }
      }
      if (el.exercise!.exCategories!.any((category) => category.name == "Push")) {
        switch (el.exercise!.targetBodyPart?.name) {
          case "Chest":
            if (el.exercise!.exTypes?.any((type) => type.name == "Weighted") == true) {
              addToList(chestWeightedList,el);
            } else if (el.exercise!.exTypes?.any((type) => type.name == "Body Weight") == true) {
              addToList(chestBodyWeightList,el);
            }
            break;
          case "Shoulders":
            if (el.exercise!.exTypes?.any((type) => type.name == "Weighted") == true) {
              addToList(shoulderWeightedList,el);
            } else if (el.exercise!.exTypes?.any((type) => type.name == "Body Weight") == true) {
              addToList(shoulderBodyWeightList,el);
            }
            break;
          case "Triceps":
            if (el.exercise!.exTypes?.any((type) => type.name == "Weighted") == true) {
              addToList(tricepsWeightedList,el);
            } else if (el.exercise!.exTypes?.any((type) => type.name == "Body Weight") == true) {
              addToList(tricepsBodyWeightList,el);
            }
            break;
        }
      }
      else if (el.exercise!.exCategories!.any((category) => category.name == "Pull")) {
        switch (el.exercise!.targetBodyPart?.name) {
          case "Back":
            if (el.exercise!.exTypes?.any((type) => type.name == "Weighted") == true) {
              addToList(backWeightedList,el);
            } else if (el.exercise!.exTypes?.any((type) => type.name == "Body Weight") == true) {
              addToList(backBodyWeightList,el);
            }
            break;
          case "Biceps":
            if (el.exercise!.exCategories!.any((c) => c.name == "Pull")) {
              if (el.exercise!.exTypes?.any((t) => t.name == "Weighted") == true) {
                addToList(pullbicepsWeightedList,el);
              } else if (el.exercise!.exTypes?.any((t) => t.name == "Body Weight") == true) {
                addToList(pullbicepsBodyWeightList,el);
              }
            }
            break;
          case "Forearms":
            if (el.exercise!.exTypes?.any((type) => type.name == "Weighted") == true) {
              addToList(forearmsWeightedList,el);
            } else if (el.exercise!.exTypes?.any((type) => type.name == "Body Weight") == true) {
              addToList(forearmsBodyWeightList,el);
            }
            break;
        }
      }
      else if (el.exercise!.exCategories!.any((category) => category.name == "Legs")) {
        switch (el.exercise!.targetBodyPart?.name) {
          case "Legs":
            if (el.exercise!.exTypes?.any((type) => type.name == "Weighted") == true) {
              addToList(legslegsWeightedList,el);
            } else if (el.exercise!.exTypes?.any((type) => type.name == "Body Weight") == true) {
              addToList(legslegsBodyWeightList,el);
            }
            break;
        }
      }
      print(chestWeightedList.length);
      print(chestBodyWeightList.length);
    }
  }

  void fetchChestExercises() {
    for (var exercise in chestBodyWeightList) {
        BodyWeightedList.add(exercise);
    }

    for (var exercise in chestWeightedList) {
        WeightedList.add(exercise);

    }
  }

  void _fetchShoulderExercises() {
    for (var exercise in shoulderBodyWeightList) {
      BodyWeightedList.add(exercise);
    }

    for (var exercise in shoulderWeightedList) {
      WeightedList.add(exercise);

    }
  }

  void _fetchTricepsExercises() {
    for (var exercise in tricepsBodyWeightList) {
      BodyWeightedList.add(exercise);
    }

    for (var exercise in tricepsWeightedList) {
      WeightedList.add(exercise);
    }
  }

  void fetchBackExercises() {
    for (var exercise in backBodyWeightList) {
      BodyWeightedList.add(exercise);
    }

    for (var exercise in backWeightedList) {
      WeightedList.add(exercise);
    }
  }

  void fetchBicepsExercises() {
    for (var exercise in pullbicepsBodyWeightList) {
      BodyWeightedList.add(exercise);
    }

    for (var exercise in pullbicepsWeightedList) {
      WeightedList.add(exercise);

    }
  }

  void fetchForearmsExercises() {
    for (var exercise in forearmsBodyWeightList) {
      BodyWeightedList.add(exercise);
    }

    for (var exercise in forearmsWeightedList) {
      WeightedList.add(exercise);

    }
  }

  void fetchLegsExercises() {
    for (var exercise in legslegsBodyWeightList) {
      BodyWeightedList.add(exercise);
    }

    for (var exercise in legslegsWeightedList) {
      WeightedList.add(exercise);

    }
  }

  void setInitialBodyPart(String category) {
    if (category.toLowerCase() == 'push') {
      targetBodyPartName.value = 'Chest';
    } else if (category.toLowerCase() == 'pull') {
      targetBodyPartName.value = 'Back';
    } else if (category.toLowerCase() == 'legs') {
      targetBodyPartName.value = 'Legs';
    } else {
      targetBodyPartName.value = '';
    }
  }

}