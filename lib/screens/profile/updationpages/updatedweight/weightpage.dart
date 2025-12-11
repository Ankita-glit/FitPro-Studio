import 'package:firstdayappsuccessor/screens/profile/updationpages/updatedweight/weightcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../helper/button/backbutton.dart';
import '../../../../helper/loader.dart';

class WeightPage extends StatelessWidget {
  WeightPage({super.key});
  WeightController controller = Get.put(WeightController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            width: Get.width,
            height: Get.height,
            color: Colors.black,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(onTap:(){
                        Get.back();
                      },child: buildBackButton()),
                    ],
                  ),
                ),
                const SizedBox(height: 53),
                Text(
                  'What is your Weight?',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Instrument Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 32),
                Column(
                  children: [
                    Container(
                      width: 106,

                      decoration: BoxDecoration(
                        color: Color(0xff2F2F2F),
                        borderRadius: BorderRadius.circular(27.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 8),
                        child: Text(
                          'Kg',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            fontFamily: 'Monstserrat Alternates',
                            color: Color(0xffC4C4C4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 44),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: _textField(size, 'Enter your weight', controller.weightcontroller),
                    ),
                  ],
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 52.0),
                  child: _continueButton(size),
                ),
              ],
            ),
          ),
          LoadingOverlay(
            isLoading: controller.isLoading,
          )
        ]
      )
    );
  }

  Widget _textField(Size size, String hint, TextEditingController controller) {
    return Container(
      height: 50,
      width: 327,
      decoration: BoxDecoration(
        color: Color(0xff2F2F2F),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        cursorColor: Color(0xffC4C4C4),
        style: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: Color(0xffC4C4C4),
        ),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hint,
          fillColor: Color(0xff2F2F2F),
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(8),
          )
        )
      )
    );
  }

  Widget _continueButton(Size size) {
    return InkWell(
      onTap: () {
    controller.UpdateWeight();
      },
      child: Center(
        child: Container(
          alignment: Alignment.center,
          width: 225,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            color: const Color(0xFFCFED51),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4C2E84).withOpacity(0.2),
                offset: const Offset(0, 15.0),
                blurRadius: 60.0,
              ),
            ],
          ),
          child: const Text(
            'Done',
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black,
              fontWeight: FontWeight.w700,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          )
        )
      )
    );
  }
}
