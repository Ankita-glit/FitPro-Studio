import 'package:firstdayappsuccessor/screens/auth/forgotpassword/resetpasscontroller.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../helper/loader.dart';

class Resetpassview extends StatelessWidget {
  Resetpassview({super.key});

  ResetPasswordController controller = Get.put(ResetPasswordController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black,
        leading: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: (){
              Get.back();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Icon(Icons.arrow_back_ios,color: Colors.white,),
            ),
          ),
        ),

      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.only(left: 24.0,right: 24),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  Text('FORGOT PASSWORD',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Instrument Sans',fontSize: 28),),
                  Padding(
                    padding: const EdgeInsets.only(right: 57.0),
                    child: Text('Please enter your email for reset the password',maxLines:2,softWrap:true,style:  TextStyle(color: Colors.white,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,fontSize: 16),),
                  ),
                  SizedBox(height: 40,),
                  Text('Email-ID',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,fontFamily: 'Instrument Sans',color: Colors.white),),
                  SizedBox(height: 10,),
                  emailTextField(size),
                  SizedBox(height: 50,),
                  ContinueButton(size),
                ],
              ),
              LoadingOverlay(
                isLoading: controller.isLoading,
              ),
            ],
          ),
        ),
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

  Widget ContinueButton(Size size) {
    return Center(
      child: SizedBox(
        width: 225,
        height: 48,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(37),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                controller.passwordReset();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(37.0),
                  color: const Color(0xFFCFED51),
                ),
                child: const Text(
                  'Reset Password',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontFamily: 'Instrument Sans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
