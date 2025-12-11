import 'package:firstdayappsuccessor/screens/pushpage/reps/repscontroller.dart';
import 'package:firstdayappsuccessor/screens/pushpage/repsweight/repsweightview.dart';
import 'package:firstdayappsuccessor/screens/widgets/app_lotties.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../helper/button/continuebtn.dart';
import 'nextscreen.dart';

class Repsview extends StatelessWidget {
  const Repsview({super.key});

  @override
  Widget build(BuildContext context) {
    Repscontroller controller = Get.put(Repscontroller());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.black,
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            Container(
              height: 353,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Image.network(
                      controller.fullimage ?? "https://example.com/default_image.png",
                      fit: BoxFit.fill,
                      width: double.infinity,
                      height: double.infinity,
                      alignment: Alignment.topCenter,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child:AppLottie.loader.build(repeat: true, width: 40,height: 40),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey.shade300,
                          child: Center(
                            child: Icon(Icons.broken_image, color: Colors.grey, size: 50),
                          ),
                        );
                      },
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ],
                ),
              ),
            ),

            // Gradient & UI overlay
            Positioned(
              top: 345,
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
                      spreadRadius: 35,
                      blurRadius: 40,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
              ),
            ),

            // Back button
            Positioned(
              top: 24,
              left: 18,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  height: 57,
                  width: 57,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0xff2F2F2F).withOpacity(0.88),
                  ),
                  child: Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 345.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Center(
                      child: Text(
                        controller.name.toString().toUpperCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Instrument Sans',
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 41),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          controller.count.value > 1 ? controller.count.value-- : null;
                        },
                        child: Image.asset('assets/images/minus.png', height: 34, width: 34),
                      ),
                      SizedBox(width: 45),
                      Obx(() => Text(
                        controller.count.value.toString(),
                        style: TextStyle(
                          color: Color(0xffCFED51),
                          fontFamily: 'Instrument Sans',
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                      SizedBox(width: 45),
                      InkWell(
                        onTap: () {
                          controller.count.value++;
                        },
                        child: Image.asset('assets/images/plus.png', height: 34, width: 34),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 62.0, left: 75, right: 75, top: 10),
        child: ButtonHelper.customButton(
          title: 'Continue',
          onTap: () {
            List<String> repsList = controller.repsControllers.map((c) => c.text).toList();

            if (controller.exType == "Body Weight") {
              if (repsList.isEmpty) {
                Get.snackbar('Missing', 'Please Enter the Reps Value');
              }

              Get.to(() => Repsweightview(), arguments: {
                'id': controller.exerciseId,
                'count': controller.count.value,
                'eximage': controller.eximage,
                'image': controller.image,
                'name': controller.name,
                'category': controller.category,
                'gender': controller.gender,
                'categories': controller.categories,
                'exType': controller.exType,
              }, transition: Transition.fadeIn);
            } else {
              Get.to(() => NextScreen(), arguments: {
                'id': controller.exerciseId,
                'count': controller.count.value,
                'eximage': controller.eximage,
                'image': controller.image,
                'name': controller.name,
                'exType': controller.exType,
                'gender': controller.gender,
                'category': controller.category,
                'categories': controller.categories,
              }, transition: Transition.fadeIn);
            }
          },
        ),
      ),
    );
  }
}
