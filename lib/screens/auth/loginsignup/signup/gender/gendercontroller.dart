import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstdayappsuccessor/helper/sharedprefrence/storedatashared.dart';
import 'package:firstdayappsuccessor/screens/auth/loginsignup/login/loginmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../../../bottomnavbar/bottomnavbarview.dart';

class GenderController extends GetxController{
  RxString selectedGender = ''.obs;
  var isCmSelected = true.obs;
  var currentStep = 0.obs;
  final weightController = TextEditingController();
  final agecontroller = TextEditingController();
  final cmController = TextEditingController();
  final Ftcontroller = TextEditingController();
  final inchController = TextEditingController();
  final box = GetStorage();
  final Dio dio = Dio();
  double? weightValue;
  RxString fullDate=''.obs;
  Loginmodel? loginmodel;
  String finalheight='';
  RxBool isfinish = false.obs;
  RxString selectedDay = ''.obs;
  RxString selectedMonth = ''.obs;
  RxString selectedYear = ''.obs;
  final TextEditingController dobDayController = TextEditingController();
  final TextEditingController dobMonthController = TextEditingController();
  final TextEditingController dobYearController = TextEditingController();
  RxBool isLoading = false.obs;


  void onInit() {
    super.onInit();
    selectedGender.value = '';
    selectedDay.value = '';
    selectedMonth.value = '';
    selectedYear.value = '';
    weightController.clear();
    cmController.clear();
    Ftcontroller.clear();
    inchController.clear();
    currentStep.value = 0;
  }

  void setGender(String gender) {
    selectedGender.value = gender;
    box.write("selectedGender", gender);
  }

  Future<void> UpdateGender() async {
    final String? userid = FirebaseAuth.instance.currentUser?.uid;
    print(userid);
    isfinish.value=true;
    isLoading.value = true;
    try {
      dio.options = BaseOptions(
        validateStatus: (status) {
          return status! < 500;
        },
      );
      final url = 'https://fitarcbe.boostproductivity.online/api/v1/user/$userid/';
      print('Making PATCH request to: $url');

      final data = {
        "gender": selectedGender.value,
        "dob": fullDate.value,
        "height": finalheight,
        "weight": weightValue
      };

      final response = await dio.patch(url, data: data);

      print('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        isLoading.value = false;
        isfinish.value=false;
        var responseData = response.data;

        if (responseData is Map<String, dynamic>) {
          loginmodel = Loginmodel.fromJson(responseData);
          await saveUserData(loginmodel!);
          Get.offAll(Bottomnavbarview());
        } else {
          isLoading.value = false;
          isfinish.value=false;
          Get.snackbar('Error', 'Invalid response format.',
              backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
        }
      } else if (response.statusCode == 404) {
        isfinish.value=false;
        isLoading.value=false;
        print('Status code 404 - User not found on the server');
      } else {
        isfinish.value=false;
        isLoading.value=false;
        Get.snackbar(''
            'Alert','Please enter valid details ${response.statusCode}',
            backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
      }
    } catch (e) {
      isfinish.value=false;
      isLoading.value=false;
      print('Error: $e');
    }
  }

  void openDatePicker(BuildContext context, String field) {
    Get.bottomSheet(
      Container(
        width: Get.width,
        height: 384,
        decoration: BoxDecoration(color: Color(0xff2F2F2F),borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDatePicker(field),
              SizedBox(height: 20),
              InkWell(
                onTap: () {
                  if (field == 'day') {
                    dobDayController.text = selectedDay.value;
                  } else if (field == 'month') {
                    dobMonthController.text = selectedMonth.value;
                  } else if (field == 'year') {
                    dobYearController.text = selectedYear.value;
                  }
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(color: Color(0xffCFED51),borderRadius: BorderRadius.circular(52)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 53.0,vertical: 13),
                    child: Text('Done',style: TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Instrument Sans',fontSize: 18,color: Colors.black),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }

  List<String> _getDaysInMonth(String month, String year) {
    if (month.isEmpty || year.isEmpty) {
      DateTime now = DateTime.now();
      month = now.month.toString();
      year = now.year.toString();
    }

      int monthIndex = [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ].indexOf(month) + 1;
    int yearInt = int.parse(year);

    int daysInMonth = DateTime(yearInt, monthIndex + 1, 0).day;

    return List.generate(daysInMonth, (index) => (index + 1).toString());
  }

  List<String> _getMonths() {
      return [
        'January', 'February', 'March', 'April', 'May', 'June',
        'July', 'August', 'September', 'October', 'November', 'December'
      ];
  }

  List<String> _getYears() {
    int currentYear = DateTime.now().year;
    return List.generate(100, (index) => (currentYear - index).toString());
  }

  void _updateFullDate() {
    if (selectedDay.value.isNotEmpty && selectedMonth.value.isNotEmpty && selectedYear.value.isNotEmpty) {
      DateTime dob = DateTime(
        int.parse(selectedYear.value),
        _getMonthIndex(selectedMonth.value),
        int.parse(selectedDay.value),
      );

      String formattedDate = DateFormat('yyyy-MM-dd').format(dob);

      fullDate.value = formattedDate;
      print('Full Date: $formattedDate');
    } else {
      fullDate.value = '';
      print('Please complete your date of birth selection.');
    }
  }

  int _getMonthIndex(String monthName) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months.indexOf(monthName) + 1;
  }

  Widget _buildDatePicker(String field) {
    if (field == 'day') {
      return Obx(
            ()=> _buildScrollList(
          items: _getDaysInMonth(selectedMonth.value, selectedYear.value),
          value: selectedDay.value,
          onChanged: (value) {
            selectedDay.value = value ?? '';
            _updateFullDate();
          },
        ),
      );
    } else if (field == 'month') {
      return Obx(
            ()=> _buildScrollList(
          items: _getMonths(),
          value: selectedMonth.value,
          onChanged: (value) {
            selectedMonth.value = value ?? '';
            _updateFullDate();
          },
        ),
      );
    } else {
      return Obx(
            ()=> _buildScrollList(
          items: _getYears(),
          value: selectedYear.value,
          onChanged: (value) {
            selectedYear.value = value ?? '';
            _updateFullDate();
          },
        ),
      );
    }
  }

  Widget _buildScrollList({
    required List<String> items,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      children: [
        Container(
          height: 260,
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  onChanged(items[index]);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: value == items[index] ? Colors.black.withOpacity(0.3) : Color(0xff2F2F2F),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      items[index],
                      style: TextStyle(
                          color:value == items[index] ?Colors.white:Color(0xff8F8F8F),
                          fontSize: 18,
                          fontFamily: 'Instrument Sans',
                          fontWeight: value == items[index] ?FontWeight.w600:FontWeight.w500
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  void onClose() {
    super.onClose();
    selectedGender.value = '';
    selectedDay.value = '';
    selectedMonth.value = '';
    selectedYear.value = '';
    weightController.clear();
    cmController.clear();
    Ftcontroller.clear();
    inchController.clear();
    currentStep.value = 0;
    Get.delete<GenderController>();

  }

}