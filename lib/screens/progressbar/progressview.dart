import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../app_route/app_pages.dart';
import '../../helper/monthcalender.dart';
import 'progresscontroller.dart';

class Progressview extends StatelessWidget {
  Progressview({super.key});
  final ProgressController controller = Get.find<ProgressController>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      controller.FetchCompletedExerciseListOnDate();
    });

    return Scaffold(
        backgroundColor: Colors.black,
        body:
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: Get.height * 0.45,
                child: MonthCalendar(),
              ),
              Obx(() {
                DateTime now = DateTime.now();
                var formattedDate = "${now.year}-${now.month}-${now.day}";
               String displayDate = controller.controller.selectedDay.value != null
                    ? DateFormat('yyyy-MM-dd').format(controller.controller.selectedDay.value)
                    : formattedDate;
                if (!controller.hasAnyExercises.value) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 100),
                    child: Text(maxLines: 2,textAlign: TextAlign.center,"You haven't done any workouts on $displayDate", style: TextStyle(color: Colors.white,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w400,fontSize: 18)),
                  );
                }

                return  Column(
                    children: [
                      if (controller.pushExercises.isNotEmpty)
                        buildExerciseStack(controller.pushExercises, 'PUSH'),
                      if (controller.pullExercises.isNotEmpty)
                        buildExerciseStack(controller.pullExercises, 'PULL'),
                      if (controller.legsExercises.isNotEmpty)
                        buildExerciseStack(controller.legsExercises, 'LEGS'),
                    ],
                  );
              })
            ]
          )
        )
    );
  }
  Widget buildExerciseStack(List exercises, String title) {
    return
        Stack(
        children: [
          GestureDetector(
            onTap: (){
              Get.toNamed(
                Routes.PROGRESSCATEGORY,
                arguments: {
                  'exercises': controller.newCompletedExercises,
                  'category': title.toLowerCase()  ,
                  'completeddate':controller.selectedDate
                }
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                height: 170,
                width: Get.width,
                margin: EdgeInsets.only(bottom: 12),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        imageUrl: controller.fetchImagePush(title),
                        fit: BoxFit.fitWidth,
                        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                    Container(color: Colors.black.withOpacity(0.5)),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: Get.width,
                        height: 30,
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
                              color: Colors.black.withOpacity(0.999),
                              spreadRadius: 15,
                              blurRadius: 30,
                              offset: Offset(0, 0),
                            )
                          ]
                        )
                      )
                    )
                  ]
                )
              )
            )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 38.0, top: 130, right: 38),
            child: Row(
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600,fontFamily: 'Instrument Sans'),
                )
              ]
            )
          )
        ]
      );}
}
