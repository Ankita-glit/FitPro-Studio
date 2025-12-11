import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../app_route/app_pages.dart';

class Resetmessageview extends StatelessWidget {
  const Resetmessageview({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black,
        leading: Material(
          color: Colors.transparent,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
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

      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 23.0,right: 33),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text('PASSWORD RESET',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Instrument Sans',fontSize: 28),),
            SizedBox(height: 4,),
            Text('password reset link has been sent to your email address. Click confirm to continue',maxLines:2,softWrap:true,style:  TextStyle(color: Colors.white,fontFamily: 'Instrument Sans',fontWeight: FontWeight.w500,fontSize: 16),),
            SizedBox(height: 50,),
            ContinueButton(size),
          ],
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
                Get.offAllNamed(Routes.LOGIN);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(37.0),
                  color: const Color(0xFFCFED51),
                ),
                child: const Text(
                  'Continue',
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
