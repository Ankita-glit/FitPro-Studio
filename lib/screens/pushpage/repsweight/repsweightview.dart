import 'package:firstdayappsuccessor/screens/pushpage/repsweight/repsweightcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Repsweightview extends StatelessWidget {
  Repsweightview({super.key});
  final Repsweightcontroller controller = Get.put(Repsweightcontroller());
  var firstset;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        final currentSet = controller.currentSetIndex.value + 1;
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
                  children: [
                    Container(
                      color: Colors.black.withOpacity(0.4),
                    ),
                  ],
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
                        spreadRadius: 38,
                        blurRadius: 35,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(top:24,left:18,child: InkWell(onTap:(){Get.back();},child: Container(height:57,width:57,decoration:BoxDecoration(borderRadius: BorderRadius.circular(50),color: Color(0xff2F2F2F).withOpacity(0.88)),child: Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 20,)))),
              Padding(
                padding: const EdgeInsets.only(top: 412.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(controller.name.toString().toUpperCase(),textAlign:TextAlign.center,softWrap:true,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Instrument Sans',fontSize: 24),
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
                      SizedBox(height: 38,),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10,left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            Container(
                              width: 160,
                              height: 49,
                              decoration: BoxDecoration(
                                color: Color(0xff2F2F2F),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xff2F2F2F),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  'Set $currentSet',
                                  style: TextStyle(
                                    color: Color(0xffC4C4C4),
                                    fontSize: 16,
                                    fontFamily: 'Instrument Sans',
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 15),
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


                    ],
                  ),
                ),
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
          final isLastSet =
              controller.currentSetIndex.value == controller.count - 1;
          final showBackButton = controller.currentSetIndex.value > 0;
          final isStartButton = !controller.isStarted.value;
          firstset = controller.currentSetIndex.value==0;

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
                      controller.startSet();
                    },
                  )
                else if (!isLastSet)
                  _buildButton(
                    label: 'Next',
                    color: Color(0xffEDD451),
                    textColor: Color(0xff000000),
                    onTap:controller.stopSet,
                  )
                else if (controller.isCompleted.value)
                    _buildButton(
                      label: 'Complete',
                      color: Color(0xffEDD451),
                      textColor: Color(0xff000000),
                      onTap: () {
                        controller.saveWorkoutDataWithWeight();

                      },
                    )
                  else
                    SizedBox(width: 154),
              ],
            ),
          );
        }),
      ),
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
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
