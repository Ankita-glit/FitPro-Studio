import 'package:firstdayappsuccessor/screens/auth/loginsignup/signup/gender/gendercontroller.dart';
import 'package:firstdayappsuccessor/screens/profile/updationpages/updatedheight/heightcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../helper/button/backbutton.dart';
import '../../../../helper/loader.dart';

class Heightpage extends StatelessWidget {
  Heightpage({super.key});
  Heightcontroller controller = Get.put(Heightcontroller());
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
                      InkWell(onTap:(){Get.back();},child: buildBackButton()),
                    ],
                  ),
                ),
                const SizedBox(height: 53),
                Text(
                  'What is your Height?',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                    fontFamily: 'Instrument Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(height: 32),
              Obx(
                    ()=> Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      unitToggle(),
                      const SizedBox(height: 37),

                      controller.isCmSelected.value?_textField(
                        size,
                        'Enter your height',
                        controller.cmController,
                      ):Row(
                        children: [
                          FtTextfield(size),
                          SizedBox(width: 15,),
                          InchTextfield(size)
                        ],
                      ),
                    ],
                  ),
                ),
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
          ),
        ],
      ),
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
          ),
        ),
      ),
    );
  }

  Widget unitToggle() {
    return Obx(
          () => Center(
        child: Container(
          width: 210,
          height: 54,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(27.5),
            border: Border.all(color: Color(0xffC4C4C4)),
          ),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => controller.isCmSelected.value = false,
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: controller.isCmSelected.value
                          ? Colors.transparent
                          : const Color(0xff2F2F2F),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Ft',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 16,
                        color: Color(0xffC4C4C4),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () => controller.isCmSelected.value = true,
                  child: Container(
                    height: double.infinity,
                    decoration: BoxDecoration(
                      color: controller.isCmSelected.value
                          ? Color(0xff2F2F2F)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'cm',
                      style: TextStyle(
                        fontFamily: 'Instrument Sans',
                        fontSize: 16,
                        color: Color(0xffC4C4C4),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget FtTextfield(Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 160,
        height: 49,

        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(
              8
          ),
        ),
        child: TextField(
          textAlign: TextAlign.center,
          controller: controller.Ftcontroller,
          style: const TextStyle(
            fontSize: 14.0,
            fontFamily: "Instrument Sans",
            fontWeight: FontWeight.w400,
            color: Color(0xffC4C4C4),
          ),
          maxLines: 1,
          onSubmitted: (value) {
            // controller.loginUserTA();
          },
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          keyboardType: TextInputType.number,
          cursorColor: Color(0xffC4C4C4),
          decoration: InputDecoration(
            hintText: 'Enter Ft',
            hintStyle: const TextStyle(
              fontSize: 14.0,
              fontFamily: "Instrument Sans",
              fontWeight: FontWeight.w400,
              color: Color(0xffC4C4C4),
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.4),
            // fillColor: controller.phone.value.text.isEmpty
            // ? Colors.black12
            //     ? const Color.fromRGBO(248, 247, 251, 1)
            //     : Colors.transparent,
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                )
            ),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                )
            ),

          ),
        ),
      ),
    );
  }

  Widget InchTextfield(Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 160,
        height: 49,

        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(
              8
          ),
        ),
        child: TextField(
          textAlign: TextAlign.center,
          controller: controller.inchController,
          style: const TextStyle(
            fontSize: 16.0,
            color: Colors.grey,
          ),
          maxLines: 1,
          onSubmitted: (value) {
            // controller.loginUserTA();
          },

          keyboardType: TextInputType.number,
          cursorColor: Color(0xffC4C4C4),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            hintText: 'Enter In',


            hintStyle: const TextStyle(
              fontSize: 14.0,
              fontFamily: "Instrument Sans",
              fontWeight: FontWeight.w400,
              color: Color(0xffC4C4C4),
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.4),
            // fillColor: controller.phone.value.text.isEmpty
            // ? Colors.black12
            //     ? const Color.fromRGBO(248, 247, 251, 1)
            //     : Colors.transparent,
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                )
            ),
            focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(8),
                    bottomRight: Radius.circular(8)),
                borderSide: BorderSide(
                  color: Colors.transparent,
                )
            ),

          ),
        ),

      ),
    );
  }

  Widget _continueButton(Size size) {
    return InkWell(
      onTap: () {
        bool isHeightSelected = (controller.isCmSelected.value && controller.cmController.text.isNotEmpty) ||
            (!controller.isCmSelected.value && controller.Ftcontroller.text.isNotEmpty && controller.inchController.text.isNotEmpty);

        if (isHeightSelected) {
          if (controller.isCmSelected.value && controller.cmController.text.isNotEmpty) {
            // Check if the height in cm is greater than or equal to 36
            double cmHeight = double.parse(controller.cmController.text);
            if (cmHeight >= 36 && cmHeight<=300) {
              controller.finalheight = controller.cmController.text;
            } else {
              Get.snackbar(
                'Alert',
                'Height must be greater than or equal to 36 or less than 300',
                backgroundColor: Color(0xff2F2F2F),
                colorText: Colors.white,
              );
              return;
            }
          } else if (!controller.isCmSelected.value && controller.Ftcontroller.text.isNotEmpty && controller.inchController.text.isNotEmpty) {
            // Convert ft to inches and add inch value
            double ftInInches = double.parse(controller.Ftcontroller.text) * 12;
            double totalInches = ftInInches + double.parse(controller.inchController.text);

            // Check if the height in inches is greater than or equal to 36
            if (totalInches >= 36 && totalInches <=300) {
              controller.finalheight = totalInches.toString();
            } else {
              Get.snackbar(
                'Alert',
                'Height must be greater than or equal to 36 inches',
                backgroundColor: Color(0xff2F2F2F),
                colorText: Colors.white,
              );
              return;
            }
          } else {
            Get.snackbar(
              'Alert',
              'Please enter your height correctly',
              backgroundColor: Color(0xff2F2F2F),
              colorText: Colors.white,
            );
            return;
          }

          // Proceed with updating the gender after height validation
          controller.UpdateHeight();
        } else {
          Get.snackbar(
            'Alert',
            'Please select your height',
            backgroundColor: Color(0xff2F2F2F),
            colorText: Colors.white,
          );
        }
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
          ),
        ),
      ),
    );
  }
}
