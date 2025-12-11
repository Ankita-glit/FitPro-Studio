import 'package:firstdayappsuccessor/screens/progressbar/progresscategory/progressdetails/progressdetailscontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../helper/button/backbutton.dart';

class Progressdetailsview extends StatelessWidget {
  Progressdetailsview({super.key});
  ProgressdetailsController controller = Get.put(ProgressdetailsController());
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        height: Get.height,
        width: Get.width,
        child: Stack(
          children: [
            Container(
              height: 353,
              width: Get.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                  image: NetworkImage(controller.fullimage ?? "https://example.com/default_image.png"),
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
                    )
                  ]
                )
              )
            ),
            Padding(
              padding: const EdgeInsets.only(top: 345.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Center(
                      child: Text(controller.exname!.toUpperCase(),textAlign:TextAlign.center,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Instrument Sans',fontSize: 24),
                      ),
                    ),
                  ),
                  SizedBox(height: 41,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36.0),
                    child: Column(
                      children: List.generate(controller.reps!.length, (index) {
                        final rep = controller.reps![index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Set: ${rep.setSerial}',
                                    style: TextStyle(
                                      color: Color(0xffCFED51),
                                      fontSize: 22,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Instrument Sans',
                                    ),
                                  ),
                                  SizedBox(width: 40),
                                  SizedBox(
                                    width: 110,
                                    child: Text(
                                      'Weight: ${rep.weight}',
                                      style: TextStyle(
                                        color: Color(0xffC4C4C4),
                                        fontFamily: 'Instrument Sans',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 20),
                                  Container(
                                    height: 30,
                                    width: 1,
                                    color: Color(0xffC4C4C4),
                                  ),
                                  SizedBox(width: 30),
                                  Text(
                                    'Reps: ${rep.repsCount}',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ]
                              ),
                              if (index < controller.reps!.length - 1) ...[
                                Divider(
                                  color: Color(0xffC4C4C4),
                                  thickness: 1,
                                )
                              ]
                            ]
                          )
                        );
                      })
                    )
                  )
                ]
              )
            ),
            Positioned(top:30,left:25,child: InkWell(onTap:(){Get.back();},child: buildBackButton())),
          ]
        )
      )
    );
  }
}
