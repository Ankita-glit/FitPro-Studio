import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../../app_route/app_pages.dart';
import '../../../../helper/loader.dart';
import 'logincontroller.dart';

class Loginview extends GetView<Logincontroller> {
  Loginview({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
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
                  top: 236,
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
                          spreadRadius: 40,
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
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Get.height*.27,),
                      Center(child: Text('SIGN IN',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 28,fontFamily: 'Instrument Sans'),)),
                      SizedBox(height: 30,),
                      InkWell(
                        onTap: (){
                          controller.googleLogin();
                        },
                        child: Container(
                          height: 40,
                          width: 327,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Color(0xff9D9D9D)),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/images/google.png',height: 20,width: 20,),
                                SizedBox(width: 12,),
                                Text('Google Sign in',style: TextStyle(fontFamily: 'Instrument Sans',fontSize: 14,fontWeight: FontWeight.w500,color: Colors.white,),),
                              ],
                            ),
                          ),

                        ),
                      ),
                      SizedBox(height: 26,),
                      Row(children: [
                        Expanded(child: Container(color: Color(0xff9D9D9D),height: 1,)),
                        Text('or',style: TextStyle(color: Color(0xff9D9D9D),fontSize: 16,fontWeight: FontWeight.w500,fontFamily: 'Inter'),),
                        Expanded(child: Container(color: Color(0xff9D9D9D),height: 1,)),

                      ],),
                      SizedBox(height: 12,),
                      Text('Email-ID',style: TextStyle(color: Colors.white,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w600,fontSize: 16),),
                      SizedBox(height: 10,),
                      emailTextField(size),
                      SizedBox(height: 20,),
                      Text('Password',style: TextStyle(color: Colors.white,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w600,fontSize: 16),),
                      SizedBox(height: 10,),
                      PasswordField(size),
                      SizedBox(height: 10,),
                      ForgotPassword(size),
                      SizedBox(height: 35,),
                      signInButton(size),
                      SizedBox(height: 12,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Not a member?',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'Instrument Sans'),),
                          InkWell(onTap:(){
                            Get.offAllNamed(Routes.SIGNUP);
                          },child: Text('Sign Up',style: TextStyle(color: Color(0xffCFED51),fontFamily: 'Instrument Sans',fontSize: 14),))
                        ],
                      ),
                    ],
                  ),
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

  Widget emailTextField(Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: Get.width-30,
        height: 49,

        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(
              8
          ),
        ),
        child: TextField(

          controller: controller.emailcontroller,
          cursorColor: Color(0xffC4C4C4),
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Color(0xffC4C4C4),

          ),
          maxLines: 1,
          onSubmitted: (value) {
          },

          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Enter your email',
            hintStyle: const TextStyle(
              fontSize: 14.0,
              fontFamily: "Montserrat",
              color: Color(0xffC4C4C4),
            ),
            filled: true,
            fillColor: Colors.grey.withOpacity(0.4),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color:Colors.transparent,
                )
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color:Colors.transparent,
                )
            ),
          ),
        ),
      ),
    );
  }

  Widget PasswordField(Size size) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: Get.width-30,
        height: 49,

        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(
              8
          ),
        ),
        child: Obx(
              ()=> TextField(
            controller: controller.passwordcontroller,
            style: const TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
            maxLines: 1,
            onSubmitted: (value) {
            },

            keyboardType: TextInputType.emailAddress,
            cursorColor: Color(0xffC4C4C4),
            obscureText: !controller.isOpen.value,
            decoration: InputDecoration(
                hintText: 'Enter your password',
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
                    borderSide: BorderSide(
                      color: Colors.transparent,
                    )
                ),
                suffixIcon: InkWell(
                    onTap: (){
                      controller.isOpen.value=!controller.isOpen.value;
                    },
                    child:Icon(controller.isOpen.value?Icons.visibility:Icons.visibility_off_outlined,color: Colors.grey,)
                )
            ),
          ),
        ),
      ),
    );
  }

  Widget signInButton(Size size) {
    return
      InkWell(
        onTap: () {
          controller.signIn();
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
            child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.black,fontFamily: 'Instrument Sans',
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
          ),
        ),
      );
  }
  
  Widget ForgotPassword(Size size) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        InkWell(
          onTap: (){
            Get.toNamed(Routes.RESETPASSWORD);
          },
          child: Text('Forget password?',style: TextStyle(color:Color(0xffCFED51),fontSize: 10,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w600),),
        ),
      ],
    );
  }
}
