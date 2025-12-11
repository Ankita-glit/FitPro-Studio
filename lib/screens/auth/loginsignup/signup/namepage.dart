import 'dart:ui';
import 'package:firstdayappsuccessor/screens/auth/loginsignup/signup/namepagecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../helper/loader.dart';

class Namepage extends StatelessWidget{
  Namepage({super.key});

  NamePageController controller = Get.put(NamePageController());

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:Stack(
        children: [
          Container(
            height: Get.height,
            width: Get.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/back.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Container(
                  color: Colors.black.withOpacity(0.4),
                ),
                Positioned(
                  top: 356,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: Get.width,
                    height: 542,
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
                          spreadRadius: 50,
                          blurRadius: 100,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 330,),
                          Center(child: Text('USERNAME',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 28,fontFamily: 'Instrument Sans'),)),
                          SizedBox(height: 34,),
                          Text('Username',style: TextStyle(color: Colors.white,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w600,fontSize: 16),),
                          SizedBox(height: 10,),
                          Namefield(size),
                          SizedBox(height: 50,),
                          ContinueButton(size),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          LoadingOverlay(
            isLoading: controller.isLoading,
          ),
        ],
      ),
    );


  }

  Widget Namefield(Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: Get.width-35,
        height: 49,
      
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(
              8
          ),
        ),
        child: TextField(
          controller: controller.nametext,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Color(0xffC4C4C4),

          ),
          maxLines: 1,
          onSubmitted: (value) {
          },
      
          keyboardType: TextInputType.name,
          cursorColor: Color(0xffC4C4C4),
          decoration: InputDecoration(
            hintText: 'Enter your Name',
            hintStyle: const TextStyle(
              fontSize: 14.0,
              fontFamily: "Montserrat",
              color: Color(0xffC4C4C4),
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.4),
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
                borderSide:BorderSide(
                    color: Colors.transparent
                )
            ),
          ),
        ),
      ),
    );
  }


  Widget ContinueButton(Size size) {
    return // Group: Button
      InkWell(
        onTap: () {
     controller.UpdateName(controller.userid);
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
              'Continue',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
  }
}
