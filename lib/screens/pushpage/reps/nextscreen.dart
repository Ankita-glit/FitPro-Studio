import 'package:firstdayappsuccessor/screens/bottomnavbar/bottomnavbarview.dart';
import 'package:firstdayappsuccessor/screens/home/homescreenview.dart';
import 'package:firstdayappsuccessor/screens/pushpage/pushpageview.dart';
import 'package:firstdayappsuccessor/screens/pushpage/reps/repscontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../app_route/app_pages.dart';
import '../../../helper/loader.dart';
import '../../home/homescreenmodel.dart';
import '../pushpagecontroller.dart';
import 'nextscreencontroller.dart';

class NextScreen extends StatelessWidget {
  NextScreen({super.key});
  final NextScreenController controller = Get.put(NextScreenController());
  Repscontroller repscontroller = Repscontroller();
var firstset;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        final currentSet = controller.currentSetIndex.value + 1;
        final totalSets = controller.count;
        return Container(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              Container(
                height: 432,
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(controller.fullimages!),
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: Stack(
                  children: [Container(color: Colors.black.withOpacity(0.4))],
                ),
              ),
              Positioned(
                top: 420,
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
                        spreadRadius: 18,
                        blurRadius: 35,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
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
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 412.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                controller.name.toString().toUpperCase(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Instrument Sans',
                                  fontSize: 20,
                                ),
                              ),
                            ),

                            Text(
                              'SET $currentSet',
                              style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Instrument Sans',
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 160,
                              height: 49,
                              decoration: BoxDecoration(
                                color: Color(0xff2F2F2F),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'Enter Reps',
                                  style: TextStyle(
                                    color: Color(0xffC4C4C4),
                                    fontSize: 16,
                                    fontFamily: 'Instrument Sans',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              width: 160,
                              height: 49,
                              decoration: BoxDecoration(
                                color: Color(0xff2F2F2F),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller:
                                    controller.repsController.length >
                                            controller.currentSetIndex.value
                                        ? controller.repsController[controller
                                            .currentSetIndex
                                            .value]
                                        : TextEditingController(),

                                style: TextStyle(
                                  color: Color(0xffC4C4C4),
                                  fontSize: 16,
                                  fontFamily: 'Instrument Sans',
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                cursorColor: Color(0xffC4C4C4),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10,
                          left: 20,
                          right: 20,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 160,
                              height: 49,
                              decoration: BoxDecoration(
                                color: Color(0xff2F2F2F),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'Enter Weight',
                                  style: TextStyle(
                                    color: Color(0xffC4C4C4),
                                    fontSize: 16,
                                    fontFamily: 'Instrument Sans',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              width: 160,
                              height: 49,
                              decoration: BoxDecoration(
                                color: Color(0xff2F2F2F),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              alignment: Alignment.center,
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller:
                                    controller.weightcontroller.length >
                                            controller.currentSetIndex.value
                                        ? controller.weightcontroller[controller
                                            .currentSetIndex
                                            .value]
                                        : TextEditingController(),

                                style: TextStyle(
                                  color: Color(0xffC4C4C4),
                                  fontSize: 16,
                                  fontFamily: 'Instrument Sans',
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                keyboardType: TextInputType.number,
                                cursorColor: Color(0xffC4C4C4),
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      controller.count > 1
                          ? buildWeightField(controller.currentSetIndex.value)
                          : SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
              LoadingOverlay(
                isLoading: controller.isLoading,
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          bottom: 62.0,
          top: 10,
          left: 25,
          right: 25,
        ),
        child: Obx(() {
          final isLastSet = controller.currentSetIndex.value == controller.count - 1;
          final showBackButton = controller.currentSetIndex.value > 0;
          final isStartButton = !controller.isStarted.value;
          firstset = controller.currentSetIndex.value == 0;

          return SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (showBackButton)
                  _buildButton(
                    label: 'Back',
                    color: Colors.transparent,
                    textColor: Color(0xffCFED51),
                    onTap: controller.previousSet,
                    isBorder: true,
                  ),
                SizedBox(width: showBackButton ? 17 : 0),
                if (isStartButton)
                  _buildButton(
                    label: 'Start',
                    color: Color(0xffCFED51),
                    textColor: Color(0xff000000),
                    onTap: () {
                      if (controller.repsController[controller.currentSetIndex.value] == 0 ||
                          controller.repsController[controller.currentSetIndex.value].text.isEmpty) {
                        Get.snackbar(
                          'Missing Reps',
                          'Please enter reps before proceeding.',
                          backgroundColor: Color(0xff2F2F2F),
                          colorText: Colors.white,
                        );
                      }
                      else {
                        String weightText = controller.weightcontroller[controller.currentSetIndex.value].text;
                        double? weight = double.tryParse(weightText);

                        if (weight == null || weight <= 0) {
                          Get.snackbar(
                            'Missing Weight',
                            'Please enter a valid weight greater than zero before proceeding.',
                            backgroundColor: Color(0xff2F2F2F),
                            colorText: Colors.white,
                          );
                        } else {
                          controller.startSet();
                        }
                      }
                    },
                  )
                else if (!isLastSet)
                  _buildButton(
                    label: 'Next',
                    color: Color(0xffEDD451),
                    textColor: Color(0xff000000),
                    onTap: controller.weightcontroller.isNotEmpty
                        ? controller.stopSet
                        : () {
                      Get.snackbar(
                        'Missing Weight',
                        'Please enter weight before proceeding.',
                        backgroundColor: Color(0xff2F2F2F),
                        colorText: Colors.white,
                      );
                    }
                  )
                else if (controller.isCompleted.value)
                    _buildButton(
                      label: 'Complete',
                      color: Color(0xffEDD451),
                      textColor: Color(0xff000000),
                      onTap: () {
                        print(
                          "Current weight for set ${controller.currentSetIndex.value}: ${controller.weightcontroller[controller.currentSetIndex.value].text}",
                        );
                        if (controller.weightcontroller.isEmpty) {
                          Get.snackbar(
                            'Missing Weight',
                            'Please enter weight for all sets before completing the workout.',
                            backgroundColor: Color(0xff2F2F2F),
                            colorText: Colors.white,
                          );
                        }
                          controller.saveWorkoutDataWithWeight();


                      }
                    )
                  else
                    SizedBox(width: 154),
              ]
            )
          );
        })
      )

    );
  }

  Widget _buildButton({
    required String label,
    required Color color,
    required Color textColor,
    required VoidCallback onTap,
    bool isBorder = false,
  }) {
    return Material(
      color: Colors.transparent,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(49),
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: onTap,
          child: Container(
            width: firstset?225:154,
            height: 48,
            decoration: BoxDecoration(
              color: isBorder ? Colors.transparent : color,
              border: isBorder ? Border.all(color: Color(0xffCFED51), width: 1) : null,
              borderRadius: BorderRadius.circular(49),
            ),
            child: Center(
              child: Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  fontFamily: 'Instrument Sans',
                  color: textColor,
                )
              )
            )
          )
        )
      )
    );
  }

  Widget buildWeightField(int index) {
    return Column(
      children: [
        if (controller.currentSetIndex.value > 0)
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () => controller.incrementWeight(index, 5), // +5kg
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xff2F2F2F),borderRadius: BorderRadius.circular(6)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0,vertical: 7),
                      child: Text(
                        "+5 kg",
                        style: TextStyle(fontSize: 12, color: Color(0xffC4C4C4),fontFamily: 'Instrument Sans',fontWeight: FontWeight.w400),
                      )
                    )
                  )
                ),
                SizedBox(width: 11,),
                GestureDetector(
                  onTap: () => controller.incrementWeight(index, 10), // +10kg
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xff2F2F2F),borderRadius: BorderRadius.circular(6)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0,vertical: 7),
                      child: Text(
                        "+10 kg",
                        style: TextStyle(fontSize: 12, color: Color(0xffC4C4C4),fontFamily: 'Instrument Sans',fontWeight: FontWeight.w400),
                      )
                    )
                  )
                ),
                SizedBox(width: 11,),
                GestureDetector(
                  onTap: () => controller.incrementWeight(index, 15), // +15kg
                  child: Container(
                    decoration: BoxDecoration(color: Color(0xff2F2F2F),borderRadius: BorderRadius.circular(6)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 7.0,vertical: 7),
                      child: Text(
                        "+15 kg",
                        style: TextStyle(fontSize: 12, color: Color(0xffC4C4C4),fontFamily: 'Instrument Sans',fontWeight: FontWeight.w400),
                      )
                    )
                  )
                )
              ]
            )
          )
      ]
    );
  }
}
