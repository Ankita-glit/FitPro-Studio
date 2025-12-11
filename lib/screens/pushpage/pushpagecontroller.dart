import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstdayappsuccessor/screens/auth/loginsignup/signup/gender/gendercontroller.dart';
import 'package:firstdayappsuccessor/screens/home/homepagemodel.dart';
import 'package:firstdayappsuccessor/screens/pushpage/pushuppagemodel.dart';
import 'package:firstdayappsuccessor/screens/pushpage/pushuppagerepo.dart';
import 'package:firstdayappsuccessor/screens/pushpage/reps/exercisecompleteondatemodel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../api_file/api_urls.dart';
import '../home/homescreencontroller.dart';
import '../home/homescreenmodel.dart';

class PushupController extends GetxController {
  GenderController controller = Get.put(GenderController());

  RxInt selectedindex = 0.obs;
  String? storename;
  RxList<CategoryExerciseModel> Pushremovedlist = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> Pullremovedlist = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> Legsremovedlist = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> WeightedList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> BodyWeightedList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> chestWeightedList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> chestBodyWeightList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> shoulderWeightedList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> shoulderBodyWeightList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> tricepsWeightedList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> tricepsBodyWeightList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> backWeightedList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> backBodyWeightList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> pullbicepsWeightedList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> pullbicepsBodyWeightList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> legsbicepsWeightedList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> legsbicepsBodyWeightList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> forearmsWeightedList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> forearmsBodyWeightList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> pulllegsWeightedList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> pulllegsBodyWeightList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> legslegsWeightedList = <CategoryExerciseModel>[].obs;
  RxList<CategoryExerciseModel> legslegsBodyWeightList = <CategoryExerciseModel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> PushCompletedExerciseList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> PullCompletedExerciseList = <CompleteExerciseListOnDatemodel>[].obs;
  RxList<CompleteExerciseListOnDatemodel> LegsCompletedExerciseList = <CompleteExerciseListOnDatemodel>[].obs;
  List<CompleteExerciseListOnDatemodel>? completeExerciseListOnDatemodel ;
  RxList<String> bodyParts = <String>[].obs;
  final Homescreencontroller homeController = Get.put(Homescreencontroller());
  String categoryName = "default";
  List<String> exercisecategoryname = [];
  List<String> listimage = [];
  List<String> items = [];
  RxList<TypeCategory> removedExercises = <TypeCategory>[].obs;
  List<CategoryExerciseModel>? categoryExerciseModel;
  RxBool isLoading = false.obs;
  String? name;
  String? image;
  RxString targetBodyPartName = ''.obs;
  RxBool istargetbodypartSelcted = false.obs;
  RxBool isFirstLoad = true.obs;
  final box = GetStorage();
  String? gender;
  String? formattedDate;
  bool isDataInitialized = false;
  bool iscompleted=false;
  var category;
  bool isYourExercises = false;


  @override
  void onInit() {
    super.onInit();

    category = Get.arguments;

    if (category is Homepagemodel) {
      name = category.name ?? 'Default Name';
      image = category.image ?? 'assets/images/push.png';
      print('Category Name: $name');
      print('Category Image: $image');
    }

    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      var args = Get.arguments as Map<String, dynamic>;
      if (args.containsKey('category')) {
        name = args['category'] ?? 'Your Exercises';
      }
      if (args.containsKey('image')) {
        image = args['image'] ?? 'assets/images/default.png';
      }

      isYourExercises = true;
      targetBodyPartName.value = 'Your Exercises';
      print("isYourExercises is set to: $isYourExercises");

    }

    print('name is $name!');
    saveCategoryNameToPrefs(name!);

    loadSaveddata();
    // if (isDataInitialized) {
    //   FetchCompletedExerciseListOnDate();
    // }

    if (isYourExercises) {
      print("Processing 'Your Exercises' data...");
      loadExerciseData().then((_) {
        fetchCategoryExercises();
        FetchCompletedExerciseListOnDate();
      });
    } else {
      print("Processing standard category data...");
      loadExerciseData().then((_) {
        fetchCategoryExercises();
        FetchCompletedExerciseListOnDate();
      });
    }
  }

  Future<void> saveCategoryNameToPrefs(String categoryName) async {
    print("Inside saveCategoryNameToPrefs method");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('categories', categoryName);
    print("Category Name saved: $categoryName");
  }

  @override
  void onReady() {
    super.onReady();
    if (!isDataInitialized) {
      FetchCompletedExerciseListOnDate();
    }
  }

  Future<void> loadSaveddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedName = prefs.getString('user_gender');

    if (storedName != null && storedName.isNotEmpty) {
      gender = storedName;
      print(gender);
    }
  }

  Future<void> fetchCategoryExercises() async {
    isLoading.value = true;
    String url = ApiUrls.categoryexerciseurl + name!;

    try {
      PushupPageRepo().CategoryexerciseRepo(
        beforeSend: () {},
        url: url,
        onSuccess: (data) {
          if (data.isSuccess) {
            categoryExerciseModel = data.resObject!;

            if (isYourExercises) {
              updateSelectedBodyPart('Your Exercises');
            }else{
              setInitialBodyPart(name!);
            }

            extractBodyParts();

            if (!isDataInitialized) {
              fetchExercisesBasedOnBodyPart();
            }

            isLoading.value = false;
          }
        },
        onError: (error) {
          print(error);
          isLoading.value = false;
        },
      );
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  void setInitialBodyPart(String category) {
    if (categoryExerciseModel != null && categoryExerciseModel!.isNotEmpty) {
      var firstExercise = categoryExerciseModel!.first;

      if (category == 'Push') {
        targetBodyPartName.value = firstExercise.targetBodyPart?.name ?? 'Chest';
      } else if (category == 'Pull') {
        targetBodyPartName.value = firstExercise.targetBodyPart?.name ?? 'Back';
      } else if (category == 'Legs') {
        targetBodyPartName.value = firstExercise.targetBodyPart?.name ?? 'Legs';
      } else {
        targetBodyPartName.value = 'Your Exercises';
      }
    }
  }

  void extractBodyParts() {
    bodyParts.clear();
    for (var exercise in categoryExerciseModel!) {
      var targetBodyPart = exercise.targetBodyPart?.name;
      if (targetBodyPart != null && !bodyParts.contains(targetBodyPart)) {
        bodyParts.add(targetBodyPart);
      }
    }
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
    Pushremovedlist.refresh();
    for (var el in categoryExerciseModel!) {
      void addToList(RxList<CategoryExerciseModel> list, CategoryExerciseModel exercise) {
        if (!list.any((e) => e.id == exercise.id) &&
            !Pushremovedlist.any((e) => e.id == exercise.id) &&
            !Pullremovedlist.any((e) => e.id == exercise.id) &&
            !Legsremovedlist.any((e) => e.id == exercise.id) &&
            !PushCompletedExerciseList.any((e) => e.exercise!.exName == exercise.exName) &&
        !PullCompletedExerciseList.any((e)=>e.exercise!.exName==exercise.exName) &&
        !LegsCompletedExerciseList.any((e)=>e.exercise!.exName==exercise.exName)
            ) {
          list.add(exercise);
        }
      }

      if (el.exCategories!.any((category) => category.name == "Push")) {
        switch (el.targetBodyPart?.name) {
          case "Chest":
            if (el.exTypes?.any((type) => type.name == "Weighted") == true) {
              addToList(chestWeightedList, el);
            } else if (el.exTypes?.any((type) => type.name == "Body Weight") == true) {
              addToList(chestBodyWeightList, el);
            }
            break;
          case "Shoulders":
            if (el.exTypes?.any((type) => type.name == "Weighted") == true) {
              addToList(shoulderWeightedList, el);
            } else if (el.exTypes?.any((type) => type.name == "Body Weight") == true) {
              addToList(shoulderBodyWeightList, el);
            }
            break;
          case "Triceps":
            if (el.exTypes?.any((type) => type.name == "Weighted") == true) {
              addToList(tricepsWeightedList, el);
            } else if (el.exTypes?.any((type) => type.name == "Body Weight") == true) {
              addToList(tricepsBodyWeightList, el);
            }
            break;
        }
      }
      else if (el.exCategories!.any((category) => category.name == "Pull")) {
        switch (el.targetBodyPart?.name) {
          case "Back":
            if (el.exTypes?.any((type) => type.name == "Weighted") == true) {
              addToList(backWeightedList, el);
            } else if (el.exTypes?.any((type) => type.name == "Body Weight") == true) {
              addToList(backBodyWeightList, el);
            }
            break;
          case "Biceps":
            if (el.exCategories!.any((c) => c.name == "Pull")) {
              if (el.exTypes?.any((t) => t.name == "Weighted") == true) {
                addToList(pullbicepsWeightedList, el);
              } else if (el.exTypes?.any((t) => t.name == "Body Weight") == true) {
                addToList(pullbicepsBodyWeightList, el);
              }
            }
            break;
          case "Forearms":
            if (el.exTypes?.any((type) => type.name == "Weighted") == true) {
              addToList(forearmsWeightedList, el);
            } else if (el.exTypes?.any((type) => type.name == "Body Weight") == true) {
              addToList(forearmsBodyWeightList, el);
            }
            break;
        }
      }
      else if (el.exCategories!.any((category) => category.name == "Legs")) {
        switch (el.targetBodyPart?.name) {
          case "Legs":
            if (el.exTypes?.any((type) => type.name == "Weighted") == true) {
              addToList(legslegsWeightedList, el);
            } else if (el.exTypes?.any((type) => type.name == "Body Weight") == true) {
              addToList(legslegsBodyWeightList, el);
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
      if (!PushCompletedExerciseList.any((e) => e.exercise!.exName == exercise.exName) &&
          !Pushremovedlist.any((e) => e.id == exercise.id) &&
          !BodyWeightedList.any((e) => e.id == exercise.id)) {
        BodyWeightedList.add(exercise);
      }
    }

    for (var exercise in chestWeightedList) {
      if (!PushCompletedExerciseList.any((e) => e.exercise!.exName == exercise.exName) &&
          !Pushremovedlist.any((e) => e.id == exercise.id) &&
          !WeightedList.any((e) => e.id == exercise.id)) {
        WeightedList.add(exercise);
      }
    }
  }

  void _fetchShoulderExercises() {
    WeightedList.addAll(shoulderWeightedList.where((e) => !WeightedList.contains(e)));
    BodyWeightedList.addAll(shoulderBodyWeightList.where((e) => !BodyWeightedList.contains(e)));
  }

  void _fetchTricepsExercises() {
    WeightedList.addAll(tricepsWeightedList.where((e) => !WeightedList.contains(e)));
    BodyWeightedList.addAll(tricepsBodyWeightList.where((e) => !BodyWeightedList.contains(e)));
  }

  void fetchBackExercises() {
    for (var exercise in backBodyWeightList) {
      if (!PullCompletedExerciseList.any((e)=>e.exercise!.exName==exercise.exName)&&
      !BodyWeightedList.any((e) => e.id == exercise.id)) {
        BodyWeightedList.add(exercise);
      }
    }

    for (var exercise in backWeightedList) {
      if (!PullCompletedExerciseList.any((e)=>e.exercise!.exName==exercise.exName)&&
      !WeightedList.any((e) => e.id == exercise.id)) {
        WeightedList.add(exercise);
      }
    }
  }

  void fetchLegsExercises() {
    for (var exercise in legslegsBodyWeightList) {
      if (!LegsCompletedExerciseList.any((e)=>e.exercise!.exName==exercise.exName)&&
      !BodyWeightedList.any((e) => e.id == exercise.id)) {
        BodyWeightedList.add(exercise);
      }
    }

    for (var exercise in legslegsWeightedList) {
      if (!LegsCompletedExerciseList.any((e)=>e.exercise!.exName==exercise.exName)&&
      !WeightedList.any((e) => e.id == exercise.id)) {
        WeightedList.add(exercise);
      }
    }
  }

  void fetchBicepsExercises() {
    for (var exercise in pullbicepsBodyWeightList) {
      if (!BodyWeightedList.any((e) => e.id == exercise.id)) {
        BodyWeightedList.add(exercise);
      }
    }

    for (var exercise in pullbicepsWeightedList) {
      if (!WeightedList.any((e) => e.id == exercise.id)) {
        WeightedList.add(exercise);
      }
    }
  }

  void fetchForearmsExercises() {
    for (var exercise in forearmsBodyWeightList) {
      if (!BodyWeightedList.any((e) => e.id == exercise.id)) {
        BodyWeightedList.add(exercise);
      }
    }

    for (var exercise in forearmsWeightedList) {
      if (!WeightedList.any((e) => e.id == exercise.id)) {
        WeightedList.add(exercise);
      }
    }
  }

  void updateSelectedBodyPart(String bodyPart) {
    targetBodyPartName.value = bodyPart;
    fetchExercisesBasedOnBodyPart();
    update();
  }

  void toggleExerciseInYourExercises(CategoryExerciseModel exercise) {
    if (exercise.exCategories!.any((category) => category.name == "Push")) {
      _toggleExerciseInList(Pushremovedlist, exercise, 'Push');
    } else if (exercise.exCategories!.any((category) => category.name == "Pull")) {
      _toggleExerciseInList(Pullremovedlist, exercise, 'Pull');
    } else if (exercise.exCategories!.any((category) => category.name == "Legs")) {
      _toggleExerciseInList(Legsremovedlist, exercise, 'Legs');
    }

    update();
    saveExerciseData();
  }

  void _toggleExerciseInList(
      RxList<CategoryExerciseModel> removedList,
      CategoryExerciseModel exercise,
      String category,
      ) {
    if (PushCompletedExerciseList.any((e) => e.exercise!.exName == exercise.exName)) {
      return;
    }
    if(PullCompletedExerciseList.any((e)=>e.exercise!.exName==exercise.exName)){
      return;
    }
    if(LegsCompletedExerciseList.any((e)=>e.exercise!.exName==exercise.exName)){
      return;
    }

    if (removedList.any((e) => e.id == exercise.id)) {
      // Remove the exercise from the removed list if it exists
      removedList.removeWhere((e) => e.id == exercise.id);
    } else {
      _removeExerciseFromBodyPartLists(exercise, category);
      removedList.add(exercise);
    }
  }

  void _removeExerciseFromBodyPartLists(CategoryExerciseModel exercise, String categoryType) {
    switch (categoryType) {
      case 'Push':
        if (exercise.exTypes?.any((el) => el.name == "Weighted") ?? false) {
          _removeFromBodyPartList(exercise, 'Weighted');
        } else if (exercise.exTypes?.any((el) => el.name == "Body Weight") ?? false) {
          _removeFromBodyPartList(exercise, 'Body Weight');
        }
        break;
      case 'Pull':
        if (exercise.exTypes?.any((el) => el.name == "Weighted") ?? false) {
          _removeFromBodyPartList(exercise, 'Weighted');
        } else if (exercise.exTypes?.any((el) => el.name == "Body Weight") ?? false) {
          _removeFromBodyPartList(exercise, 'Body Weight');
        }
        break;
      case 'Legs':
        if (exercise.exTypes?.any((el) => el.name == "Weighted") ?? false) {
          _removeFromBodyPartList(exercise, 'Weighted');
        } else if (exercise.exTypes?.any((el) => el.name == "Body Weight") ?? false) {
          _removeFromBodyPartList(exercise, 'Body Weight');
        }
        break;
      default:
        break;
    }
  }

  void _removeFromBodyPartList(CategoryExerciseModel exercise, String type) {
    switch (exercise.targetBodyPart?.name) {
      case 'Chest':
        if (type == 'Weighted') {
          chestWeightedList.remove(exercise);
        } else {
          chestBodyWeightList.remove(exercise);
        }
        break;
      case 'Shoulders':
        if (type == 'Weighted') {
          shoulderWeightedList.remove(exercise);
        } else {
          shoulderBodyWeightList.remove(exercise);
        }
        break;
      case 'Triceps':
        if (type == 'Weighted') {
          tricepsWeightedList.remove(exercise);
        } else {
          tricepsBodyWeightList.remove(exercise);
        }
        break;
      case 'Back':
        if (type == 'Weighted') {
          backWeightedList.remove(exercise);
        } else {
          backBodyWeightList.remove(exercise);
        }
        break;
      case 'Biceps':
        if (exercise.exCategories?.any((el) => el.name == "Pull") ?? false) {
          if (type == 'Weighted') {
            pullbicepsWeightedList.remove(exercise);
          } else {
            pullbicepsBodyWeightList.remove(exercise);
          }
        }
        break;
      case 'Forearms':
        if (exercise.exCategories?.any((el) => el.name == "Pull") ?? false) {
          if (type == 'Weighted') {
            forearmsWeightedList.remove(exercise);
          } else {
            forearmsBodyWeightList.remove(exercise);
          }
        }
        break;
      case 'Legs':
        if (type == 'Weighted') {
          legslegsWeightedList.remove(exercise);
        } else {
          legslegsBodyWeightList.remove(exercise);
        }
        break;
      default:
        break;
    }
  }

  void saveExerciseData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Pushremovedlist', jsonEncode(Pushremovedlist));
    prefs.setString('Pullremovedlist', jsonEncode(Pullremovedlist));
    prefs.setString('Legsremovedlist', jsonEncode(Legsremovedlist));
    prefs.setString('chestWeightedList', jsonEncode(chestWeightedList));
    prefs.setString('chestBodyWeightedList',jsonEncode(chestBodyWeightList));
    prefs.setString('backWeightedList',jsonEncode(backWeightedList));
    prefs.setString('backBodyWeightedList',jsonEncode(backBodyWeightList));
    prefs.setString('legsWeightedList',jsonEncode(legslegsWeightedList));
    prefs.setString('legsBodyWeightedList',jsonEncode(legslegsBodyWeightList));

  }

  Future<void> loadExerciseData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool isChestWeightedListLoaded = false;
    bool isChestBodyWeightedListLoaded = false;
    bool isBackWeightedListLoaded = false;
    bool isBackBodyWeightedListLoaded = false;
    bool isLegslegsWeightedListLoaded = false;
    bool isLegslegsBodyWeightedListLoaded = false;

    bool isDataLoaded = false;

    String? PushremovedListData = prefs.getString('Pushremovedlist');
    print(PushremovedListData);
    if (PushremovedListData != null && PushremovedListData.isNotEmpty) {
      try {
        List<dynamic> decodedList = jsonDecode(PushremovedListData);
        List<CategoryExerciseModel> tempPushRemovedList = decodedList
            .map((item) => CategoryExerciseModel.fromJson(item as Map<String, dynamic>))
            .toList();
        Pushremovedlist.value = tempPushRemovedList;
        isDataLoaded = true;
      } catch (e) {
        print('Error decoding Pushremovedlist data: $e');
      }
      finally{
        isLoading.value = false;
      }
    }
    String? PullremovedListData = prefs.getString('Pullremovedlist');
    if (PullremovedListData != null && PullremovedListData.isNotEmpty) {
      try {
        List<dynamic> decodedList = jsonDecode(PullremovedListData);
        List<CategoryExerciseModel> tempPullRemovedList = decodedList
            .map((item) => CategoryExerciseModel.fromJson(item as Map<String, dynamic>))
            .toList();
        Pullremovedlist.value = tempPullRemovedList;
        isDataLoaded = true;
      } catch (e) {
        print('Error decoding Pullremovedlist data: $e');
      }
      finally{
        isLoading.value = false;
      }
    }
    String? LegsremovedListData = prefs.getString('Legsremovedlist');
    if (LegsremovedListData != null && LegsremovedListData.isNotEmpty) {
      try {
        List<dynamic> decodedList = jsonDecode(LegsremovedListData);
        List<CategoryExerciseModel> tempLegsRemovedList = decodedList
            .map((item) => CategoryExerciseModel.fromJson(item as Map<String, dynamic>))
            .toList();
        Legsremovedlist.value = tempLegsRemovedList;
        isDataLoaded = true;
      } catch (e) {
        print('Error decoding Legsremovedlist data: $e');
      }
      finally{
        isLoading.value = false;
      }
    }

    String? chestWeightedData = prefs.getString('chestWeightedList');
    if (chestWeightedData != null && chestWeightedData.isNotEmpty && chestWeightedData!='[]') {
      try {
        List<dynamic> decodedList = jsonDecode(chestWeightedData);
        List<CategoryExerciseModel> tempChestWeightedList = decodedList
            .map((item) => CategoryExerciseModel.fromJson(item as Map<String, dynamic>))
            .toList();
        chestWeightedList.value = tempChestWeightedList;
        isChestWeightedListLoaded = true;
      } catch (e) {
        print('Error decoding chestWeightedList data: $e');
      }
      finally{
        isLoading.value = false;
      }
    }

    String? chestBodyWeightedData = prefs.getString('chestBodyWeightedList');
    if (chestBodyWeightedData != null && chestBodyWeightedData.isNotEmpty && chestBodyWeightedData!='[]') {
      try {
        List<dynamic> decodedList = jsonDecode(chestBodyWeightedData);
        List<CategoryExerciseModel> tempChestBodyWeightedList = decodedList
            .map((item) => CategoryExerciseModel.fromJson(item as Map<String, dynamic>))
            .toList();
        chestBodyWeightList.value = tempChestBodyWeightedList;
        isChestBodyWeightedListLoaded = true;
      } catch (e) {
        print('Error decoding chestBodyWeightedList data: $e');
      }
      finally{
        isLoading.value = false;
      }
    }

    String? backWeightedData = prefs.getString('backWeightedList');
    if (backWeightedData != null && backWeightedData.isNotEmpty && backWeightedData!='[]') {
      try {
        List<dynamic> decodedList = jsonDecode(backWeightedData);
        List<CategoryExerciseModel> tempBackWeightedList = decodedList
            .map((item) => CategoryExerciseModel.fromJson(item as Map<String, dynamic>))
            .toList();
        backWeightedList.value = tempBackWeightedList;
        isBackWeightedListLoaded = true;
      } catch (e) {
        print('Error decoding backWeightedList data: $e');
      }
      finally{
        isLoading.value = false;
      }
    }

    String? backBodyWeightedData = prefs.getString('backBodyWeightedList');
    if (backBodyWeightedData != null && backBodyWeightedData.isNotEmpty && backBodyWeightedData!='[]') {
      try {
        List<dynamic> decodedList = jsonDecode(backBodyWeightedData);
        List<CategoryExerciseModel> tempBackBodyWeightedList = decodedList
            .map((item) => CategoryExerciseModel.fromJson(item as Map<String, dynamic>))
            .toList();
        backBodyWeightList.value = tempBackBodyWeightedList;
        isBackBodyWeightedListLoaded = true;
      } catch (e) {
        print('Error decoding backBodyWeightedList data: $e');
      }
      finally{
        isLoading.value = false;
      }
    }

    String? legsWeightedData = prefs.getString('legsWeightedList');
    if (legsWeightedData != null && legsWeightedData.isNotEmpty && legsWeightedData!='[]') {
      try {
        List<dynamic> decodedList = jsonDecode(legsWeightedData);
        List<CategoryExerciseModel> tempLegsWeightedList = decodedList
            .map((item) => CategoryExerciseModel.fromJson(item as Map<String, dynamic>))
            .toList();
        legslegsWeightedList.value = tempLegsWeightedList;
        isLegslegsWeightedListLoaded = true;
      } catch (e) {
        print('Error decoding legslegsWeightedList data: $e');
      }
      finally{
        isLoading.value = false;
      }
    }

    // Load legslegsBodyWeightedList
    String? legsBodyWeightedData = prefs.getString('legsBodyWeightedList');
    if (legsBodyWeightedData != null && legsBodyWeightedData.isNotEmpty && legsBodyWeightedData!='[]') {
      try {
        List<dynamic> decodedList = jsonDecode(legsBodyWeightedData);
        List<CategoryExerciseModel> tempLegsBodyWeightedList = decodedList
            .map((item) => CategoryExerciseModel.fromJson(item as Map<String, dynamic>))
            .toList();
        legslegsBodyWeightList.value = tempLegsBodyWeightedList;
        isLegslegsBodyWeightedListLoaded = true;
      } catch (e) {
        print('Error decoding legslegsBodyWeightedList data: $e');
      }finally{
        isLoading.value = false;
      }
    }

    if (isChestWeightedListLoaded &&
        isChestBodyWeightedListLoaded &&
        isBackWeightedListLoaded &&
        isBackBodyWeightedListLoaded &&
        isLegslegsWeightedListLoaded &&
        isLegslegsBodyWeightedListLoaded) {
      isDataInitialized = true;
      print('All data loaded successfully');
    } else {
      print('Some data failed to load');
    }
  }
  // Future<void> FetchCompletedExerciseListOnDate() async {
  //   if (name == null || name!.isEmpty) {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     storename = prefs.getString('categories');
  //   }
  //
  //   // Validate that name is available
  //   if (name == null || name!.isEmpty) {
  //     Get.snackbar("Alert", "Exercise name is missing.");
  //     return;
  //   }
  //
  //   // Initialize loader before fetching
  //   isLoading.value = true;
  //
  //   DateTime now = DateTime.now();
  //   formattedDate = "${now.year}-${now.month}-${now.day}";
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? storedgender = prefs.getString('user_gender');
  //   gender = storedgender;
  //   String uid = FirebaseAuth.instance.currentUser!.uid ?? '';
  //
  //   String baseurl = "https://fitarcbe.boostproductivity.online/api/v1/";
  //   String url = baseurl + "user/" + uid + "/exercises/" + formattedDate! + "/" + "category/" + name! + '/';
  //
  //   try {
  //     // Delay fetch call until previous data is loaded (e.g., after gender is set or any flag is true)
  //     if (!isDataInitialized) {
  //       // Wait until initialization is complete before calling the fetch function
  //       await Future.delayed(Duration(milliseconds: 500)); // Adjust timing as needed
  //     }
  //
  //     PushupPageRepo().CompleteExerciseListOnTimeRepo(
  //       beforeSend: () {},
  //       url: url,
  //       onSuccess: (data) {
  //         if (data.isSuccess) {
  //           List<CompleteExerciseListOnDatemodel> newCompletedExercises = data.resObject!;
  //
  //           iscompleted = true;
  //
  //           if (newCompletedExercises.isNotEmpty) {
  //             // Process completed exercises
  //             for (var completedExercise in newCompletedExercises) {
  //               switch (name) {
  //                 case 'Push':
  //                   Pushremovedlist.removeWhere((exercise) => exercise.exName == completedExercise.exercise!.exName!);
  //                   break;
  //                 case 'Pull':
  //                   Pullremovedlist.removeWhere((exercise) => exercise.exName == completedExercise.exercise!.exName!);
  //                   break;
  //                 case 'Legs':
  //                   Legsremovedlist.removeWhere((exercise) => exercise.exName == completedExercise.exercise!.exName!);
  //                   break;
  //               }
  //             }
  //
  //             saveExerciseData();
  //
  //             for (var completedExercise in newCompletedExercises) {
  //               switch (name) {
  //                 case 'Push':
  //                   if (!PushCompletedExerciseList.any((exercise) => exercise.exercise!.exName == completedExercise.exercise!.exName)) {
  //                     PushCompletedExerciseList.add(completedExercise);
  //                   }
  //                   break;
  //                 case 'Pull':
  //                   if (!PullCompletedExerciseList.any((exercise) => exercise.exercise!.exName == completedExercise.exercise!.exName)) {
  //                     PullCompletedExerciseList.add(completedExercise);
  //                   }
  //                   break;
  //                 case 'Legs':
  //                   if (!LegsCompletedExerciseList.any((exercise) => exercise.exercise!.exName == completedExercise.exercise!.exName)) {
  //                     LegsCompletedExerciseList.add(completedExercise);
  //                   }
  //                   break;
  //               }
  //             }
  //             update();
  //           }
  //         }
  //         // Stop loading here after fetching data
  //         isLoading.value = false;
  //       },
  //       onError: (error) {
  //         print(error);
  //         isLoading.value = false; // Hide loader on error
  //         Get.snackbar("Alert", "Please Enter Valid data ${error}");
  //       },
  //     );
  //   } catch (error) {
  //     print(error);
  //     isLoading.value = false; // Hide loader on exception
  //     Get.snackbar("Alert", "Please Enter Valid data ${error}");
  //   }
  // }


  Future<void> FetchCompletedExerciseListOnDate() async {
    if (name == null || name!.isEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      storename = prefs.getString('categories');
    }
    if (name == null || name!.isEmpty) {
      Get.snackbar("Alert", "Exercise name is missing.");
      return;
    }

    DateTime now = DateTime.now();
    formattedDate = "${now.year}-${now.month}-${now.day}";
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedgender = prefs.getString('user_gender');
    gender = storedgender;
    String uid = FirebaseAuth.instance.currentUser!.uid ?? '';

    String baseurl = "https://fitarcbe.boostproductivity.online/api/v1/";
    String url = baseurl + "user/" + uid + "/exercises/" + formattedDate! + "/" + "category/" + name! + '/';

    try {
      PushupPageRepo().CompleteExerciseListOnTimeRepo(
        beforeSend: () {},
        url: url,
        onSuccess: (data) {
          if (data.isSuccess) {
            List<CompleteExerciseListOnDatemodel> newCompletedExercises = data.resObject!;

            iscompleted = true;

            if (newCompletedExercises.isNotEmpty) {
              for (var completedExercise in newCompletedExercises) {
                switch (name) {
                  case 'Push':
                    Pushremovedlist.removeWhere((exercise) => exercise.exName == completedExercise.exercise!.exName!);
                    break;
                  case 'Pull':
                    Pullremovedlist.removeWhere((exercise) => exercise.exName == completedExercise.exercise!.exName!);
                    break;
                  case 'Legs':
                    Legsremovedlist.removeWhere((exercise) => exercise.exName == completedExercise.exercise!.exName!);
                    break;
                }
              }

              saveExerciseData();

              for (var completedExercise in newCompletedExercises) {
                switch (name) {
                  case 'Push':
                    if (!PushCompletedExerciseList.any((exercise) => exercise.exercise!.exName == completedExercise.exercise!.exName)) {
                      PushCompletedExerciseList.add(completedExercise);
                    }
                    break;
                  case 'Pull':
                    if (!PullCompletedExerciseList.any((exercise) => exercise.exercise!.exName == completedExercise.exercise!.exName)) {
                      PullCompletedExerciseList.add(completedExercise);
                    }
                    break;
                  case 'Legs':
                    if (!LegsCompletedExerciseList.any((exercise) => exercise.exercise!.exName == completedExercise.exercise!.exName)) {
                      LegsCompletedExerciseList.add(completedExercise);
                    }
                    break;
                }
              }
              update();
            }
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

  void onClose(){
    super.onClose();
  }

}


