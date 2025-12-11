import 'package:cached_network_image/cached_network_image.dart';
import 'package:firstdayappsuccessor/screens/pushpage/pushpagecontroller.dart';
import 'package:firstdayappsuccessor/screens/pushpage/pushuppagemodel.dart';
import 'package:firstdayappsuccessor/screens/pushpage/reps/exercisecompleteondatemodel.dart';
import 'package:firstdayappsuccessor/screens/pushpage/reps/repscontroller.dart';
import 'package:firstdayappsuccessor/screens/widgets/app_lotties.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app_route/app_pages.dart';
import '../../helper/button/backbutton.dart';
import '../../helper/button/continuebtn.dart';

class Pushpageview extends StatelessWidget {
  Pushpageview({super.key});
  PushupController controller = Get.put(PushupController());
  String? fullimage;

  @override
  Widget build(BuildContext context) {
    controller. FetchCompletedExerciseListOnDate();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(
          ()=> controller.isLoading.value
            ? Center(child: Container(height:40,width:40,child: AppLottie.loader.build(repeat: true)))
            :Container(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              _buildBackgroundImage(controller),
              _buildGradientOverlay(),
              Padding(
                padding: const EdgeInsets.only(top: 160.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(controller),
                    SizedBox(height: 20),
                    _buildCategoryTabs(controller),
                    SizedBox(height: 30),
                    Obx(() => Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (controller.targetBodyPartName.value == 'Your Exercises') ...[
                              if (controller.categoryExerciseModel!.any((el) => el.exCategories!.any((category) => category.name == "Push"))) ...[
                                 if (controller.Pushremovedlist.isNotEmpty && controller.PushCompletedExerciseList.isNotEmpty) ...[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    'Upcoming Exercises',
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
                  child: Obx(
    ()=> Text(
                      '(${controller.Pushremovedlist.length} exercises)',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Instrument Sans',
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ...controller.Pushremovedlist.map((exercise) {
              return InkWell(
                onTap: () {
                  String? exType = '';
                  if (exercise.exTypes != null && exercise.exTypes!.isNotEmpty) {
                    exType = exercise.exTypes!
                        .firstWhere(
                            (el) => el.name == 'Weighted' || el.name == 'Body Weight',
                        orElse: () => ExType(name: '')
                    )
                        .name;
                  };
                  Get.delete<Repscontroller>();
                  Get.toNamed(Routes.REPS, arguments: {
                    'category':"Push",
                    'id':exercise.id,
                    'eximage':exercise.exImage,
                    'image':controller.image,
                    'name':exercise.exName,
                    'type':exercise.exTypes,
                    'gender':controller.gender,
                    'exType': exType,
                    'categories':controller.category

                  });
                },
                child: _buildExerciseCard(exercise, controller),
              );
            }).toList(),
            SizedBox(height: 10,),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Text(
                    'Completed Exercises',
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
                  child: Obx(
    ()=> Text(
                      '(${controller.PushCompletedExerciseList.length} exercises)',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Instrument Sans',
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ...controller.PushCompletedExerciseList.map((exercise) {
              return _buildExerciseCardCompleted(exercise, controller);
            }).toList(),
          ],
        ),
      ]
                                else if (controller.Pushremovedlist.isNotEmpty) ...[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 25.0),
                                            child: Text(
                                              'Upcoming Exercises',
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
                                            child: Text(
                                              '(${controller.Pushremovedlist.length} exercises)',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Instrument Sans',
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      ...controller.Pushremovedlist.map((exercise) {
                                        return InkWell(
                                          onTap: () {
                                            String? exType = '';
                                            if (exercise.exTypes != null && exercise.exTypes!.isNotEmpty) {
                                              exType = exercise.exTypes!
                                                  .firstWhere(
                                                      (el) => el.name == 'Weighted' || el.name == 'Body Weight',
                                                  orElse: () => ExType(name: '')
                                              )
                                                  .name;
                                            };
                                            Get.delete<Repscontroller>();
                                            Get.toNamed(Routes.REPS, arguments: {
                                              'category':"Push",
                                              'id':exercise.id,
                                              'eximage':exercise.exImage,
                                              'image':controller.image,
                                              'name':exercise.exName,
                                              'type':exercise.exTypes,
                                              'gender':controller.gender,
                                              'exType': exType,
                                              'categories':controller.category

                                            });
                                          },
                                          child: _buildExerciseCard(exercise, controller),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ]

                                else if(controller.PushCompletedExerciseList.isNotEmpty) ...[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 25.0),
                                            child: Text(
                                              'Completed Exercises',
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
                                            child: Text(
                                              '(${controller.PushCompletedExerciseList.length} exercises)',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Instrument Sans',
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      ...controller.PushCompletedExerciseList.map((exercise) {
                                        return _buildExerciseCardCompleted(exercise, controller);
                                      }).toList(),
                                    ],
                                  ),
                                ]
                                else ...[
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                        child: Column(
                                          children: [
                                            SizedBox(height: Get.height * 0.2),
                                            ButtonHelper.customButton(
                                              title: 'Add exercises',
                                              onTap: () {
                                                controller.updateSelectedBodyPart('Chest');
                                              },
                                            ),
                                            SizedBox(height: 20),
                                            Center(
                                              child: Text(
                                                textAlign: TextAlign.center,
                                                "Add exercises from other subcategories to start workout",
                                                style: TextStyle(
                                                  color: Color(0xffFFFFFF),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'Instrument Sans',
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                              ]

                              else if (controller.categoryExerciseModel!.any((el) => el.exCategories!.any((category) => category.name == "Pull"))) ...[
                                if (controller.Pullremovedlist.isNotEmpty && controller.PullCompletedExerciseList.isNotEmpty) ...[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 25.0),
                                            child: Text(
                                              'Upcoming Exercises',
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
                                            child: Text(
                                              '(${controller.Pullremovedlist.length} exercises)',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Instrument Sans',
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      ...controller.Pullremovedlist.map((exercise) {
                                        return InkWell(
                                          onTap: () {
                                            String? exType = '';
                                            if (exercise.exTypes != null && exercise.exTypes!.isNotEmpty) {
                                              exType = exercise.exTypes!
                                                  .firstWhere(
                                                      (el) => el.name == 'Weighted' || el.name == 'Body Weight',
                                                  orElse: () => ExType(name: '')
                                              )
                                                  .name;
                                            };
                                            Get.delete<Repscontroller>();
                                            Get.toNamed(Routes.REPS, arguments: {
                                              'category':"Pull",
                                              'id':exercise.id,
                                              'eximage':exercise.exImage,
                                              'image':controller.image,
                                              'name':exercise.exName,
                                              'type':exercise.exTypes,
                                              'gender':controller.gender,
                                              'exType': exType,
                                              'categories':controller.category
                                            });
                                          },
                                          child: _buildExerciseCard(exercise, controller),
                                        );
                                      }).toList(),
SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 25.0),
                                            child: Text(
                                              'Completed Exercises',
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
                                            child: Text(
                                              '(${controller.PullCompletedExerciseList.length} exercises)',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Instrument Sans',
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      ...controller.PullCompletedExerciseList.map((exercise) {
                                        return _buildExerciseCardCompleted(exercise, controller);
                                      }).toList(),
                                    ],
                                  ),
                                ]
                                else if (controller.Pullremovedlist.isNotEmpty) ...[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 25.0),
                                            child: Text(
                                              'Upcoming Exercises',
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
                                            child: Text(
                                              '(${controller.Pullremovedlist.length} exercises)',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'Instrument Sans',
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      ...controller.Pullremovedlist.map((exercise) {
                                        return InkWell(
                                          onTap: () {
                                            String? exType = '';
                                            if (exercise.exTypes != null && exercise.exTypes!.isNotEmpty) {
                                              exType = exercise.exTypes!
                                                  .firstWhere(
                                                      (el) => el.name == 'Weighted' || el.name == 'Body Weight',
                                                  orElse: () => ExType(name: '')
                                              )
                                                  .name;
                                            };
                                            Get.delete<Repscontroller>();
                                            Get.toNamed(Routes.REPS, arguments: {
                                              'category':"Pull",
                                              'id':exercise.id,
                                              'eximage':exercise.exImage,
                                              'image':controller.image,
                                              'name':exercise.exName,
                                              'type':exercise.exTypes,
                                              'gender':controller.gender,
                                              'exType': exType,
                                              'categories':controller.category

                                            });
                                          },
                                          child: _buildExerciseCard(exercise, controller),
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ]

                                else if(controller.PullCompletedExerciseList.isNotEmpty) ...[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 25.0),
                                              child: Text(
                                                'Completed Exercises',
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
                                              child: Text(
                                                '(${controller.PullCompletedExerciseList.length} exercises)',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Instrument Sans',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        ...controller.PullCompletedExerciseList.map((exercise) {
                                          return _buildExerciseCardCompleted(exercise, controller);
                                        }).toList(),
                                      ],
                                    ),
                                  ]
                                  else ...[
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                          child: Column(
                                            children: [
                                              SizedBox(height: Get.height * 0.2),
                                              ButtonHelper.customButton(
                                                title: 'Add exercises',
                                                onTap: () {
                                                  controller.updateSelectedBodyPart('Back');
                                                },
                                              ),
                                              SizedBox(height: 20),
                                              Center(
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  "Add exercises from other categories to start workout",
                                                  style: TextStyle(
                                                    color: Color(0xffFFFFFF),
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w400,
                                                    fontFamily: 'Instrument Sans',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                              ]

                              else if (controller.categoryExerciseModel!.any((el) => el.exCategories!.any((category) => category.name == "Legs"))) ...[
                                  if (controller.Legsremovedlist.isNotEmpty && controller.LegsCompletedExerciseList.isNotEmpty) ...[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 25.0),
                                              child: Text(
                                                'Upcoming Exercises',
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
                                              child: Text(
                                                '(${controller.Legsremovedlist.length} exercises)',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Instrument Sans',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        ...controller.Legsremovedlist.map((exercise) {
                                          return InkWell(
                                            onTap: () {
                                              String? exType = '';
                                              if (exercise.exTypes != null && exercise.exTypes!.isNotEmpty) {
                                                exType = exercise.exTypes!
                                                    .firstWhere(
                                                        (el) => el.name == 'Weighted' || el.name == 'Body Weight',
                                                    orElse: () => ExType(name: '')
                                                )
                                                    .name;
                                              };
                                              Get.delete<Repscontroller>();
                                              Get.toNamed(Routes.REPS, arguments: {
                                                'category':"Legs",
                                                'id':exercise.id,
                                                'eximage':exercise.exImage,
                                                'image':controller.image,
                                                'name':exercise.exName,
                                                'type':exercise.exTypes,
                                                'exType': exType,
                                                'categories':controller.category
                                              });
                                            },
                                            child: _buildExerciseCard(exercise, controller),
                                          );
                                        }).toList(),
SizedBox(height:10),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 25.0),
                                              child: Text(
                                                'Completed Exercises',
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
                                              child: Text(
                                                '(${controller.LegsCompletedExerciseList.length} exercises)',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Instrument Sans',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        ...controller.LegsCompletedExerciseList.map((exercise) {
                                          return _buildExerciseCardCompleted(exercise, controller);
                                        }).toList(),
                                      ],
                                    ),
                                  ]
                                  else if (controller.Legsremovedlist.isNotEmpty) ...[
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(left: 25.0),
                                              child: Text(
                                                'Upcoming Exercises',
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
                                              child: Text(
                                                '(${controller.Legsremovedlist.length} exercises)',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'Instrument Sans',
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        ...controller.Legsremovedlist.map((exercise) {
                                          return InkWell(
                                            onTap: () {
                                              String? exType = '';
                                              if (exercise.exTypes != null && exercise.exTypes!.isNotEmpty) {
                                                exType = exercise.exTypes!
                                                    .firstWhere(
                                                        (el) => el.name == 'Weighted' || el.name == 'Body Weight',
                                                    orElse: () => ExType(name: '')
                                                )
                                                    .name;
                                              };
                                              Get.delete<Repscontroller>();
                                              Get.toNamed(Routes.REPS, arguments: {
                                                'category':"Legs",
                                                'id':exercise.id,
                                                'eximage':exercise.exImage,
                                                'image':controller.image,
                                                'name':exercise.exName,
                                                'type':exercise.exTypes,
                                                'exType': exType,
                                                'categories':controller.category

                                              });
                                            },
                                            child: _buildExerciseCard(exercise, controller),
                                          );
                                        }).toList(),
                                        SizedBox(height:10),
                                      ],
                                    ),
                                  ]

                                  else if(controller.LegsCompletedExerciseList.isNotEmpty) ...[

                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 25.0),
                                                child: Text(
                                                  'Completed Exercises',
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
                                                child: Text(
                                                  '(${controller.LegsCompletedExerciseList.length} exercises)',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'Instrument Sans',
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 20),
                                          ...controller.LegsCompletedExerciseList.map((exercise) {
                                            return _buildExerciseCardCompleted(exercise, controller);
                                          }).toList(),
                                        ],
                                      ),
                                    ]
                                    else ...[
                                        Center(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                                            child: Column(
                                              children: [
                                                SizedBox(height: Get.height * 0.2),
                                                ButtonHelper.customButton(
                                                  title: 'Add exercises',
                                                  onTap: () {
                                                    controller.updateSelectedBodyPart('Legs');
                                                  },
                                                ),
                                                SizedBox(height: 20),
                                                Center(
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    "Add exercises from Legs category to start workout",
                                                    style: TextStyle(
                                                      color: Color(0xffFFFFFF),
                                                      fontSize: 18,
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: 'Instrument Sans',
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                ]

                            ],
                            if(controller.targetBodyPartName.value=='Chest') ...[
                            if (controller.chestWeightedList.isNotEmpty)
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
                                    child: Text('(${controller.chestWeightedList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ...controller.chestWeightedList.map((exercise) {
                                return _buildExerciseCard(exercise, controller);
                              }).toList(),

                              SizedBox(height: 25),
                            if (controller.chestBodyWeightList.isNotEmpty) ...[
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
                                    child: Text('(${controller.chestBodyWeightList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              ...controller.chestBodyWeightList.map((exercise) {
                                return _buildExerciseCard(exercise, controller);
                              }).toList(),
                            ],],
                            if(controller.targetBodyPartName.value=='Shoulders') ...[
                              if (controller.shoulderWeightedList.isNotEmpty)
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
                                      child: Text('(${controller.shoulderWeightedList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                    ),
                                  ],
                                ),
                              SizedBox(height: 20),
                              ...controller.shoulderWeightedList.map((exercise) {
                                return _buildExerciseCard(exercise, controller);
                              }).toList(),

                              SizedBox(height: 25),
                              if (controller.shoulderBodyWeightList.isNotEmpty) ...[
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
                                      child: Text('(${controller.shoulderBodyWeightList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                ...controller.shoulderBodyWeightList.map((exercise) {
                                  return _buildExerciseCard(exercise, controller);
                                }).toList(),
                              ],],
                            if(controller.targetBodyPartName.value=='Triceps') ...[
                              if (controller.tricepsWeightedList.isNotEmpty)
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
                                      child: Text('(${controller.tricepsWeightedList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                    ),
                                  ],
                                ),
                              SizedBox(height: 20),
                              ...controller.tricepsWeightedList.map((exercise) {
                                return _buildExerciseCard(exercise, controller);
                              }).toList(),

                              SizedBox(height: 25),
                              if (controller.tricepsBodyWeightList.isNotEmpty) ...[
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
                                      child: Text('(${controller.tricepsBodyWeightList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                ...controller.tricepsBodyWeightList.map((exercise) {
                                  return _buildExerciseCard(exercise, controller);
                                }).toList(),
                              ],],
                            if (controller.targetBodyPartName.value == 'Biceps') ...[
                                // Biceps under Pull category
                                if (controller.pullbicepsWeightedList.isNotEmpty)
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
                                        child: Text('(${controller.pullbicepsWeightedList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                      ),
                                    ],
                                  ),
                                SizedBox(height: 20),
                                ...controller.pullbicepsWeightedList.map((exercise) {
                                  return _buildExerciseCard(exercise, controller);
                                }).toList(),

                                SizedBox(height: 25),
                                if (controller.pullbicepsBodyWeightList.isNotEmpty) ...[
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
                                        child: Text('(${controller.pullbicepsBodyWeightList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  ...controller.pullbicepsBodyWeightList.map((exercise) {
                                    return _buildExerciseCard(exercise, controller);
                                  }).toList(),
                                ],
                              ],
                            if(controller.targetBodyPartName.value=='Back') ...[
                                if (controller.backWeightedList.isNotEmpty)
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
                                        child: Text('(${controller.backWeightedList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                      ),
                                    ],
                                  ),
                                SizedBox(height: 20),
                                ...controller.backWeightedList.map((exercise) {
                                  return _buildExerciseCard(exercise, controller);
                                }).toList(),

                                SizedBox(height: 25),
                                if (controller.backBodyWeightList.isNotEmpty) ...[
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
                                        child: Text('(${controller.backBodyWeightList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  ...controller.backBodyWeightList.map((exercise) {
                                    return _buildExerciseCard(exercise, controller);
                                  }).toList(),
                                ],],
                            if(controller.targetBodyPartName.value=='Forearms') ...[
                                if (controller.forearmsWeightedList.isNotEmpty)
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
                                        child: Text('(${controller.forearmsWeightedList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                      ),
                                    ],
                                  ),
                                SizedBox(height: 20),
                                ...controller.forearmsWeightedList.map((exercise) {
                                  return _buildExerciseCard(exercise, controller);
                                }).toList(),

                                SizedBox(height: 25),
                                if (controller.forearmsBodyWeightList.isNotEmpty) ...[
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
                                        child: Text('(${controller.forearmsBodyWeightList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  ...controller.forearmsBodyWeightList.map((exercise) {
                                    return _buildExerciseCard(exercise, controller);
                                  }).toList(),
                                ],],
                            if (controller.targetBodyPartName.value == 'Legs') ...[
                                // Legs under Legs category
                                if (controller.legslegsWeightedList.isNotEmpty)
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
                                        child: Text('(${controller.legslegsWeightedList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                      ),
                                    ],
                                  ),
                                SizedBox(height: 20),
                                ...controller.legslegsWeightedList.map((exercise) {
                                  return _buildExerciseCard(exercise, controller);
                                }).toList(),

                                SizedBox(height: 25),
                                if (controller.legslegsBodyWeightList.isNotEmpty) ...[
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
                                        child: Text('(${controller.legslegsBodyWeightList.length} exercises)',style: TextStyle(fontSize: 14,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,color: Colors.white),),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  ...controller.legslegsBodyWeightList.map((exercise) {
                                    return _buildExerciseCard(exercise, controller);
                                  }).toList(),
                                ],
                              ],
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
              Positioned(top:30,left:25,child: InkWell(onTap:(){controller.saveExerciseData();Get.back();},child: buildBackButton())),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExerciseCard(CategoryExerciseModel exercise, PushupController controller) {
    RxList<CategoryExerciseModel> removedList;

    if (exercise.exCategories!.any((category) => category.name == "Push")) {
      removedList = controller.Pushremovedlist;
    } else if (exercise.exCategories!.any((category) => category.name == "Pull")) {
      removedList = controller.Pullremovedlist;
    } else if (exercise.exCategories!.any((category) => category.name == "Legs")) {
      removedList = controller.Legsremovedlist;
    } else {
      removedList = controller.Pushremovedlist;
    }

    bool isExerciseAdded = removedList.contains(exercise);

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
          _buildExerciseImage(exercise.exImage!, controller.gender!),
          SizedBox(width: 14),
          SizedBox(
            width: Get.width - 151,
            child: Text(
              exercise.exName!,
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
            padding: const EdgeInsets.only(right: 10.0),
            child: InkWell(
              onTap: () {
                controller.toggleExerciseInYourExercises(exercise);
              },
              child: Container(
                color: Colors.transparent,
                width: 40,
                height: 40,
                alignment: Alignment.center,
                child: Image.asset(
                  isExerciseAdded ? "assets/images/minus.png" : "assets/images/plus.png",
                  height: 20,
                  width: 20,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBackgroundImage(PushupController controller) {
    String baseUrl = "https://fitarcbe.boostproductivity.online";

    String? fullImage = baseUrl + controller.image!;
    print(fullImage!);

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
            imageUrl: fullImage,
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
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildHeader(PushupController controller) {
  //   // Initialize variables for length
  //   String? pushLength;
  //   String? pulllength;
  //   String? legslength;
  //
  //   // Ensure that categoryExerciseModel is not null
  //   if (controller.categoryExerciseModel != null) {
  //     // Iterate through the model only if it's not null
  //     controller.categoryExerciseModel!.forEach((el) {
  //       el.exCategories!.forEach((category) {
  //         if (category.name == "Push") {
  //           pushLength = category.exCount.toString();
  //         }
  //         if (category.name == "Pull") {
  //           pulllength = category.exCount.toString();
  //         }
  //         if (category.name == "Legs") {
  //           legslength = category.exCount.toString();
  //         }
  //       });
  //     });
  //   }
  //
  //   // Build the header widget
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 23.0, right: 28),
  //     child: Row(
  //       children: [
  //         Text(
  //           controller.name!.toUpperCase(),
  //           style: TextStyle(
  //             color: Colors.white,
  //             fontSize: 28,
  //             fontWeight: FontWeight.w700,
  //             fontFamily: 'Instrument Sans',
  //           ),
  //         ),
  //         Spacer(),
  //         // Display lengths for Push, Pull, and Legs categories
  //         if (pushLength != null)
  //           Text(
  //             '${pushLength!} exercises',
  //             style: TextStyle(
  //               fontSize: 14,
  //               fontFamily: 'Instrument Sans',
  //               fontWeight: FontWeight.w500,
  //               color: Colors.white,
  //             ),
  //           ),
  //         if (pulllength != null)
  //           Text(
  //             '${pulllength!} exercises',
  //             style: TextStyle(
  //               fontSize: 14,
  //               fontFamily: 'Instrument Sans',
  //               fontWeight: FontWeight.w500,
  //               color: Colors.white,
  //             ),
  //           ),
  //         if (legslength != null)
  //           Text(
  //             '${legslength!} exercises',
  //             style: TextStyle(
  //               fontSize: 14,
  //               fontFamily: 'Instrument Sans',
  //               fontWeight: FontWeight.w500,
  //               color: Colors.white,
  //             ),
  //           ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildHeader(PushupController controller) {
    String? pushLength;
    String? pulllength;
    String? legslenght;

    controller.categoryExerciseModel!.forEach((el) {
      el.exCategories!.forEach((category) {
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
            controller.name!.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.w700,
              fontFamily: 'Instrument Sans',
            ),
          ),
          Spacer(),
          if(pushLength!=null)
            Text('${pushLength!} exercises', style: TextStyle(
            fontSize: 14,
            fontFamily: 'Instrument Sans',
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),),
          if(pulllength!=null)
            Text('${pulllength!} exercises', style: TextStyle(
              fontSize: 14,
              fontFamily: 'Instrument Sans',
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),),
          if(legslenght!=null)
            Text('${legslenght!} exercises', style: TextStyle(
              fontSize: 14,
              fontFamily: 'Instrument Sans',
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs(PushupController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 24.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Obx(
                ()=> InkWell(
                onTap: (){
                  controller.updateSelectedBodyPart('Your Exercises');
                },
                child: Container(
                  height: 28,
                  margin: EdgeInsets.only(top: 6, bottom: 6, right: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color:controller.targetBodyPartName.value == 'Your Exercises'
                        ? Color(0xffCFED51)
                        : Color(0xff2F2F2F),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5.53),
                    child: Text(
                      'Your Exercises',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: controller.targetBodyPartName.value == 'Your Exercises'
                            ? Color(0xff000000)
                            : Colors.white,
                        fontSize: 9.85,
                        fontFamily: 'Instrument Sans',
                        fontWeight: controller.targetBodyPartName.value == 'Your Exercises'
                            ? FontWeight.w800
                            : FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: 3,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
            SizedBox(width: 10,),
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
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList()
                    :[Container()],
              );
            }),
          ],
        ),
      ),
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

  Widget _buildExerciseCardCompleted(CompleteExerciseListOnDatemodel exercise, PushupController controller) {
  String? exerciseName = exercise.exercise?.exName;
  String? exerciseImage = exercise.exercise?.exImage;

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
        _buildExerciseImage(exerciseImage!, controller.gender!),
        SizedBox(width: 14),

        SizedBox(
          width: Get.width - 150,
          child: Text(
            exerciseName!,
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
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset('assets/images/complete.png',height: 20,width: 20,),
        ),
      ],
    ),
  );
}

}

