import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firstdayappsuccessor/helper/customcalender.dart';
import 'package:firstdayappsuccessor/screens/home/homescreencontroller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../app_route/app_pages.dart';
import '../pushpage/pushpagecontroller.dart';
import '../widgets/app_lotties.dart';

class Homescreenview extends StatelessWidget {
  final Homescreencontroller controller = Get.put(Homescreencontroller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 14),
          child: Column(
            children: [
              CustomCalendar(),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "What would you like to do today?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Instrument Sans',
                  ),
                ),
              ),
              const SizedBox(height: 32),

              Obx(
                  ()=> controller.isLoading.value?Center(child: Container(height:40,width:40,child: AppLottie.loader.build(repeat: true))):Expanded(
                  child:ListView.builder(
                        itemCount: controller.homepagemodel.length,padding: EdgeInsets.zero,
                        itemBuilder: (context, index) {
                          String base_imageurl="https://fitarcbe.boostproductivity.online";
                          var category = controller.homepagemodel![index];

                          String imageUrl = base_imageurl + category.image!;

                          return InkWell(
                            splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () {
                                Get.toNamed(Routes.PUSHUPVIEW,arguments: category);
                                Get.put(PushupController());

                              },
                              child: workoutCard(
                                  category.name!,
                                  "${category.exCount!} exercises",
                                  imageUrl),
                            );
                        }
                      )
                  )
              )

            ]
          )
        )
      )
    );
  }

  Widget workoutCard(String title, String subtitle, String imageUrl) {

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Container(

              height: 170,
              width: Get.width,
              margin: EdgeInsets.only(bottom: 12),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: BoxFit.fitWidth,
                    placeholder: (context, url) => Center(child: SizedBox()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Container(
                  color: Colors.black.withOpacity(0.5),
                ),
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
        ),
        Padding(
          padding: const EdgeInsets.only(left: 38.0,top: 130,right: 38),
          child: Row(
            children: [
              Text(
                title.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Instrument Sans'

                ),
              ),
              Spacer(),
              Text(
                subtitle.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  fontFamily: 'Instrument Sans',

                  color: Colors.white,
                )
              )
            ]
          )
        )
      ]
    );
  }

}


