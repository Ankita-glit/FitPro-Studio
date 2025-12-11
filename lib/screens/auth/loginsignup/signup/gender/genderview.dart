import 'package:firstdayappsuccessor/screens/auth/loginsignup/signup/gender/gendercontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../../helper/loader.dart';

class Genderview extends GetView<GenderController> {
  Genderview({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(
            () => Container(
          width: Get.width,
          height: Get.height,
          color: Colors.black,
          child: Stack(
            children: [
              SingleChildScrollView(child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),
                  Obx(() {
                    double progress = (controller.currentStep.value + 1) / 4;
                    return Container(
                      height: 10,
                      width: 203,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.withOpacity(0.3),
                      ),
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: progress,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: const Color(0xffCFED51),
                          ),
                        ),
                      ),
                    );
                  }),

                  const SizedBox(height: 47),
                  Text(
                    _getTitle(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Instrument Sans',
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 32),

                  _buildStepContent(size,context),
                ],
              )),
              LoadingOverlay(
                isLoading: controller.isLoading,
              ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 52),
        child: Obx(()=> _continueButton(size)),
      ),
    );
  }

  String _getTitle() {
    switch (controller.currentStep.value) {
      case 0:
        return 'What is Your gender?';
      case 1:
        return 'What is Your Age?';
      case 2:
        return 'What is Your weight?';
      case 3:
        return 'What is Your height?';
      default:
        return '';
    }
  }

  Widget _buildStepContent(Size size,BuildContext context) {
    switch (controller.currentStep.value) {
      case 0:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Column(
            children: [
              _genderRadioButton(size, 'Male'),
              const SizedBox(height: 15),
              _genderRadioButton(size, 'Female'),
            ],
          ),
        );
      case 1:
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: [
                  Container(
                    width: 101,
                    height: 49,
                    child: InkWell(
                      onTap: () => controller.openDatePicker(context, 'day'),
                      child: _buildDateField(
                        controller.dobDayController,
                        'Day',
                      ),
                    ),
                  ),
                  SizedBox(width: 12,),
                  Container(
                    width: 101,
                    height: 49,
                    child: InkWell(
                      onTap: () => controller.openDatePicker(context, 'month'),
                      child: _buildDateField(
                        controller.dobMonthController,
                        'Month',
                      ),
                    ),
                  ),
                  SizedBox(width: 12,),
                  Container(
                    width: 101,
                    height: 49,
                    child: InkWell(
                      onTap: () => controller.openDatePicker(context, 'year'),
                      child: _buildDateField(
                        controller.dobYearController,
                        'Year',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      case 2:
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xff2F2F2F),
                borderRadius: BorderRadius.circular(27.5)
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0,vertical:8),
                child: Text('Kg',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,fontFamily: 'Monstserrat Alternates',color: Color(0xffC4C4C4)),),
              ),
            ),
            SizedBox(height: 44,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: _textField(size, 'Enter your weight', controller.weightController),
            ),
          ],
        );
      case 3:
        return Obx(
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
        );
      default:
        return const SizedBox();
    }
  }

  Widget _genderRadioButton(Size size, String gender) {
    return Obx(
        ()=> InkWell(
        onTap: () {
          controller.selectedGender.value = gender;
          print(controller.selectedGender.value);
        },
        child: Container(
          width: 327,
          height:49,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: Color(0xff2F2F2F),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                gender,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Color(0xffC4C4C4),
                  fontWeight: FontWeight.w400,
                  fontFamily: "Instrument Sans",
                ),
              ),
              Icon(
                controller.selectedGender.value == gender
                    ? Icons.radio_button_checked
                    : Icons.radio_button_off,
                color: Color(0xffC4C4C4),size: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField(Size size, String hint, TextEditingController controller) {
    return Container(
      height: 50,
      width: 327,
      decoration: BoxDecoration(
        color: Color(0xff2F2F2F),
        borderRadius: BorderRadius.circular(8)
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
    return controller.currentStep.value == 0
        ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 75.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Material(
              child: InkWell(
                    onTap: () {
              if (controller.selectedGender.value.isEmpty) {
                Get.snackbar('Error', 'Please select your gender',
                    backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
              } else {

                controller.currentStep.value++;
              }
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                                  width: 225,
                                  alignment: Alignment.center,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.0),
                                    color: const Color(0xFFCFED51),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 73.0),
                                    child: const Text(
                                      'Continue',
                                      style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                      ),
                    ),
                  ),
            ),
          ),
        )
        : Padding(
          padding: const EdgeInsets.only(left: 25.0,right: 25),
          child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  if (controller.currentStep.value > 0) {
                    controller.currentStep.value--;
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: 48,
                  width: 154,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: Colors.transparent,
                    border:
                    Border.all(color: const Color(0xffCFED51), width: 1),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8),
                  child: const Text(
                    'Previous',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Color(0xffCFED51),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 17,),
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Material(
              child: InkWell(
                onTap: () {
                  if (controller.currentStep.value == 3) {
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
                      Future.delayed(Duration(milliseconds: 100), () {
                        controller.UpdateGender(); // or Get.offAll(...) etc.
                      });
                    } else {
                      Get.snackbar(
                        'Alert',
                        'Please select your height',
                        backgroundColor: Color(0xff2F2F2F),
                        colorText: Colors.white,
                      );
                    }
                  }

                  else if(controller.currentStep.value==1){
                    ((controller.selectedDay.value!=null && controller.selectedDay.value.isNotEmpty) && (controller.selectedMonth.value!=null && controller.selectedMonth.value.isNotEmpty)  && (controller.selectedYear.value!=null && controller.selectedYear.value.isNotEmpty))?
                    controller.currentStep.value++:
                    Get.snackbar('Alert', 'Please select your date of birth',
                        backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
                  }
                  else {
                    if (controller.weightController.text.isNotEmpty) {
                      controller.weightValue = double.parse(controller.weightController.text);
                      if(controller.weightValue!>=30){
                        controller.currentStep.value++;
                      }else{
                        Get.snackbar(
                          'Alert',
                          'Please enter your weight greater than 30',
                          backgroundColor: Color(0xff2F2F2F),
                          colorText: Colors.white,
                        );
                      }
                      // Proceed to the next step
                    } else {
                      Get.snackbar(
                        'Alert',
                        'Please select your weight',
                        backgroundColor: Color(0xff2F2F2F),
                        colorText: Colors.white,
                      );
                    }
                  }

                },
                child: Container(
                  alignment: Alignment.center,
                  height: 48,
                  width: 154,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: const Color(0xFFCFED51),
                  ),

                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          )
                ],
              ),
        );
  }

  Widget _buildDateField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 1.0),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.white),
          filled: true,
          fillColor: Color(0xff2F2F2F),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          enabled: false,
        ),
      ),
    );
  }
}
