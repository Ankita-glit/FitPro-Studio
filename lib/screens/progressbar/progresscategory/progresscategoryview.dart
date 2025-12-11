import 'package:cached_network_image/cached_network_image.dart';
import 'package:firstdayappsuccessor/helper/dateconverter/dateconvert.dart';
import 'package:firstdayappsuccessor/screens/progressbar/progresscategory/progresscategorycontroller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../app_route/app_pages.dart';
import '../../../helper/button/backbutton.dart';
import '../../pushpage/reps/exercisecompleteondatemodel.dart';

class Progresscategoryview extends StatelessWidget {

  Progresscategoryview({super.key});
  ProgresscategoryController progresscategoryController = Get.put(ProgresscategoryController());
  String? fullimage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            _buildBackgroundImage(progresscategoryController.newCompletedExercises!,progresscategoryController.selectedCategory!),
            _buildGradientOverlay(),
            Padding(
              padding: const EdgeInsets.only(top: 160.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(progresscategoryController),
                  SizedBox(height: 20),
                  _buildCategoryTabs(progresscategoryController),
                  SizedBox(height: 30),
                  Obx(() => Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(progresscategoryController.targetBodyPartName.value=='Chest') ...[
                            if (progresscategoryController.chestWeightedList.isNotEmpty) ...[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      'Weighted Exercises',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily: 'Instrument Sans',
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text('(${progresscategoryController.chestWeightedList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                            ...progresscategoryController.chestWeightedList.map((exercise) {
                              return _buildExerciseCard(exercise, progresscategoryController);
                            }).toList(),
                              SizedBox(height: 25),],


                            if (progresscategoryController.chestBodyWeightList.isNotEmpty) ...[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      'Body Weight Exercises',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily: 'Instrument Sans',
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text('(${progresscategoryController.chestBodyWeightList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ...progresscategoryController.chestBodyWeightList.map((exercise) {
                                return _buildExerciseCard(exercise, progresscategoryController);
                              }).toList(),
                            ],
                            if (progresscategoryController.chestWeightedList.isEmpty &&
                                progresscategoryController.chestBodyWeightList.isEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 210),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "You haven't done any chest workouts on ${formatDateWithSuffix(progresscategoryController.selectedDay!)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Instrument Sans',
                                  ),
                                ),
                              ),
                          ],
                          if(progresscategoryController.targetBodyPartName.value=='Shoulders') ...[
                            if (progresscategoryController.shoulderWeightedList.isNotEmpty)  ...[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      'Weighted Exercises',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily: 'Instrument Sans',
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text('(${progresscategoryController.shoulderWeightedList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ...progresscategoryController.shoulderWeightedList.map((exercise) {
                              return _buildExerciseCard(exercise, progresscategoryController);
                            }).toList(),
                              SizedBox(height: 25,),
],
                            if (progresscategoryController.shoulderBodyWeightList.isNotEmpty) ...[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      'Body Weight Exercises',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily: 'Instrument Sans',
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text('(${progresscategoryController.shoulderBodyWeightList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ...progresscategoryController.shoulderBodyWeightList.map((exercise) {
                                return _buildExerciseCard(exercise, progresscategoryController);
                              }).toList(),
                            ],
                            if (progresscategoryController.shoulderWeightedList.isEmpty &&
                                progresscategoryController.shoulderBodyWeightList.isEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 210),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "You haven't done any shoulder workouts on ${formatDateWithSuffix(progresscategoryController.selectedDay!)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Instrument Sans',
                                  ),
                                ),
                              ),
                          ],
                          if(progresscategoryController.targetBodyPartName.value=='Triceps') ...[
                            if (progresscategoryController.tricepsWeightedList.isNotEmpty)...[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      'Weighted Exercises',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily: 'Instrument Sans',
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text('(${progresscategoryController.tricepsWeightedList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                  ),
                                ],
                              ),
                            SizedBox(height: 20),
                            ...progresscategoryController.tricepsWeightedList.map((exercise) {
                              return _buildExerciseCard(exercise, progresscategoryController);
                            }).toList(),
                              SizedBox(height: 25,)
                            ],

                            if (progresscategoryController.tricepsBodyWeightList.isNotEmpty) ...[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      'Body Weight Exercises',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily: 'Instrument Sans',
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text('(${progresscategoryController.tricepsBodyWeightList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ...progresscategoryController.tricepsBodyWeightList.map((exercise) {
                                return _buildExerciseCard(exercise, progresscategoryController);
                              }).toList(),
                            ],
                            if (progresscategoryController.tricepsWeightedList.isEmpty &&
                                progresscategoryController.tricepsBodyWeightList.isEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 210),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "You haven't done any triceps workouts on ${formatDateWithSuffix(progresscategoryController.selectedDay!)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Instrument Sans',
                                  ),
                                ),
                              ),
                          ],
                          if (progresscategoryController.targetBodyPartName.value == 'Biceps') ...[
                            if (progresscategoryController.pullbicepsWeightedList.isNotEmpty)...[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      'Weighted Exercises',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily: 'Instrument Sans',
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text('(${progresscategoryController.pullbicepsWeightedList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                  ),
                                ],
                              ),
                            SizedBox(height: 20),
                            ...progresscategoryController.pullbicepsWeightedList.map((exercise) {
                              return _buildExerciseCard(exercise, progresscategoryController);
                            }).toList(),
                            SizedBox(height: 25),
                            ],
                            if (progresscategoryController.pullbicepsBodyWeightList.isNotEmpty) ...[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      'Body Weight Exercises',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily: 'Instrument Sans',
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text('(${progresscategoryController.pullbicepsBodyWeightList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ...progresscategoryController.pullbicepsBodyWeightList.map((exercise) {
                                return _buildExerciseCard(exercise, progresscategoryController);
                              }).toList(),
                            ],
                            if (progresscategoryController.pullbicepsWeightedList.isEmpty &&
                                progresscategoryController.pullbicepsBodyWeightList.isEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 210),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "You haven't done any biceps workouts on ${formatDateWithSuffix(progresscategoryController.selectedDay!)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Instrument Sans',
                                  ),
                                ),
                              ),
                          ],
                          if(progresscategoryController.targetBodyPartName.value=='Back') ...[
                            if (progresscategoryController.backWeightedList.isNotEmpty)...[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      'Weighted Exercises',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily: 'Instrument Sans',
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text('(${progresscategoryController.backWeightedList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                  ),
                                ],
                              ),
                            SizedBox(height: 20),
                            ...progresscategoryController.backWeightedList.map((exercise) {
                              return _buildExerciseCard(exercise, progresscategoryController);
                            }).toList(),

                            SizedBox(height: 25),
                            ],
                            if (progresscategoryController.backBodyWeightList.isNotEmpty) ...[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      'Body Weight Exercises',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily: 'Instrument Sans',
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text('(${progresscategoryController.backBodyWeightList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ...progresscategoryController.backBodyWeightList.map((exercise) {
                                return _buildExerciseCard(exercise, progresscategoryController);
                              }).toList(),
                            ],
                            if (progresscategoryController.backWeightedList.isEmpty &&
                                progresscategoryController.backBodyWeightList.isEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 210),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "You haven't done any back workouts on ${formatDateWithSuffix(progresscategoryController.selectedDay!)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Instrument Sans',
                                  ),
                                ),
                              ),
                          ],
                          if(progresscategoryController.targetBodyPartName.value=='Forearms') ...[
                            if (progresscategoryController.forearmsWeightedList.isNotEmpty)...[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      'Weighted Exercises',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily: 'Instrument Sans',
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text('(${progresscategoryController.forearmsWeightedList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                  ),
                                ],
                              ),
                            SizedBox(height: 20),
                            ...progresscategoryController.forearmsWeightedList.map((exercise) {
                              return _buildExerciseCard(exercise, progresscategoryController);
                            }).toList(),

                            SizedBox(height: 25),
                            ],
                            if (progresscategoryController.forearmsBodyWeightList.isNotEmpty) ...[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      'Body Weight Exercises',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily: 'Instrument Sans',
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text('(${progresscategoryController.forearmsBodyWeightList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ...progresscategoryController.forearmsBodyWeightList.map((exercise) {
                                return _buildExerciseCard(exercise, progresscategoryController);
                              }).toList(),
                            ],
                            if (progresscategoryController.forearmsWeightedList.isEmpty &&
                                progresscategoryController.forearmsBodyWeightList.isEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 210),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "You haven't done any forearms workouts on ${formatDateWithSuffix(progresscategoryController.selectedDay!)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Instrument Sans',
                                  ),
                                ),
                              ),
                          ],
                          if (progresscategoryController.targetBodyPartName.value == 'Legs') ...[
                            if (progresscategoryController.legslegsWeightedList.isNotEmpty)...[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      'Weighted Exercises',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily: 'Instrument Sans',
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text('(${progresscategoryController.legslegsWeightedList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                  ),
                                ],
                              ),
                            SizedBox(height: 20),
                            ...progresscategoryController.legslegsWeightedList.map((exercise) {
                              return _buildExerciseCard(exercise, progresscategoryController);
                            }).toList(),

                            SizedBox(height: 25),
                            ],
                            if (progresscategoryController.legslegsBodyWeightList.isNotEmpty) ...[
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25.0),
                                    child: Text(
                                      'Body Weight Exercises',
                                      style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                        fontFamily: 'Instrument Sans',
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text('(${progresscategoryController.legslegsBodyWeightList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ...progresscategoryController.legslegsBodyWeightList.map((exercise) {
                                return _buildExerciseCard(exercise, progresscategoryController);
                              }).toList(),
                            ],
                            if (progresscategoryController.legslegsWeightedList.isEmpty &&
                                progresscategoryController.legslegsBodyWeightList.isEmpty)
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 210),
                                child: Text(
                                  textAlign: TextAlign.center,
                                  "You haven't done any legs workouts on ${formatDateWithSuffix(progresscategoryController.selectedDay!)}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'Instrument Sans',
                                  ),
                                ),
                              ),
                          ],
                        ]
                      )
                    )
                  ))
                ]
              )
            ),
            Positioned(top:30,left:25,child: InkWell(onTap:(){Get.back();},child: buildBackButton())),
          ]
        )
      )
    );
  }

  Widget _buildBackgroundImage(List<CompleteExerciseListOnDatemodel> exercises, String selectedCategory) {
    String imageUrl = _getCategoryImage(exercises, selectedCategory);

    return Container(
      height: 244.72,
      width: Get.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: imageUrl,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            placeholder: (context, url) => Center(
              child: Container(
                decoration: BoxDecoration(color: Colors.grey.shade50),
              ),
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          Container(
            color: Colors.black.withOpacity(0.4),
          ),
        ],
      ),
    );
  }

  String _getCategoryImage(List<CompleteExerciseListOnDatemodel> exercises, String selectedCategory) {
    String baseUrl = "https://fitarcbe.boostproductivity.online";
    for (var exercise in exercises) {
      var categories = exercise.exercise?.exCategories ?? [];
      for (var category in categories) {
        if (category.name?.toLowerCase() == selectedCategory.toLowerCase() && category.image != null) {
          return baseUrl + category.image!;
        }
      }
    }
    return '';
  }

  Widget _buildGradientOverlay() {
    return Positioned(
      top: 190,
      left: 0,
      right: 0,
      child: Container(
        width: Get.width,
        height: Get.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.9),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              spreadRadius: 80,
              blurRadius: 90,
              offset: Offset(0, 0),
            )
          ]
        )
      )
    );
  }

  Widget _buildHeader(ProgresscategoryController controller) {
    String? pushLength;
    String? pulllength;
    String? legslenght;

    controller.newCompletedExercises!.forEach((el) {
      el.exercise!.exCategories!.forEach((category) {
        if (category.name == "Push") {
          pushLength = category.exCount.toString();
        }
        if(category.name=="Pull"){
          pulllength = category.exCount.toString();
        }
        if(category.name=="Legs"){
          legslenght = category.exCount.toString();
        }
      });
    });
    return Padding(
      padding: const EdgeInsets.only(left: 23.0, right: 28),
      child: Row(
        children: [
          Text(
            controller.selectedCategory!.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              fontFamily: 'Instrument Sans',
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: Text(formatDateWithSuffix(controller.selectedDay!),style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,fontFamily: 'Instrument Sans',color: Colors.white),),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(ProgresscategoryController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Obx(() {
              return Row(
                children: controller.bodyParts.isNotEmpty?
                controller.bodyParts.map((bodyPart) {
                  return InkWell(
                    onTap: () {
                      controller.updateSelectedBodyPart(bodyPart);
                    },
                    child: Container(
                      height: 28,
                      margin: EdgeInsets.only(top: 6, bottom: 6, right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: controller.targetBodyPartName.value == bodyPart
                            ? Color(0xffCFED51)
                            : Color(0xff2F2F2F),
                      ),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.83, vertical: 5.53),
                        child: Text(
                          bodyPart,
                          softWrap: true,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: controller.targetBodyPartName.value == bodyPart
                                ? Color(0xff000000)
                                : Color(0xffC4C4C4),
                            fontSize: 9.85,
                            fontFamily: 'Instrument Sans',
                            fontWeight: controller.targetBodyPartName.value == bodyPart
                                ? FontWeight.w800
                                : FontWeight.w700,
                          )
                        )
                      )
                    )
                  );
                }).toList()
                    :[Container()],
              );
            })
          ]
        )
      )
    );
  }

  Widget _buildExerciseCard(CompleteExerciseListOnDatemodel exercise, ProgresscategoryController controller) {
    return InkWell(
      onTap: (){
        Get.toNamed(Routes.PROGRESSDETAILSPAGE,arguments: {
          'eximage':exercise.exercise!.exImage,
          'exname':exercise.exercise!.exName,
          'reps':exercise.reps,
          'gender':controller.gender
        });
      },
      child: Container(
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
            _buildExerciseImage(exercise.exercise!.exImage!, controller.gender!),
            SizedBox(width: 14),
            SizedBox(
              width: Get.width - 140,
              child: Text(
                exercise.exercise!.exName!,
                maxLines: 2,
                softWrap: true,
                style: TextStyle(
                  color: Color(0xffC4C4C4),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'Instrument Sans',
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: InkWell(
                onTap: () {
                },
                child: Image.asset(
             'assets/images/arrow.png',
                  height: 15,
                  width: 15,
                )
              )
            )
          ]
        )
      )
    );
  }

  Widget _buildExerciseImage(String exerciseImage,String gender) {
    String baseurl = "https://fitarcbe.boostproductivity.online";
    String trimmedImage = exerciseImage.substring(0, exerciseImage.length - 5);
    fullimage = baseurl + trimmedImage + gender + ".webp";
    print(fullimage);
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
          ),
        ),
      ),
    );
  }

}
