import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app_route/app_pages.dart';

class Loginsignupview extends StatelessWidget {
  const Loginsignupview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: Get.height,
        width: Get.width,
        child: Stack(
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
                    top: 597,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: Get.width,
                      height: 215,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.9),
                            spreadRadius: 100,
                            blurRadius: 60,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Get.height*0.76,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Welcome to FitArc',style: TextStyle(fontWeight:FontWeight.w600,color: Color(0xffC0C0C0),fontFamily: 'Instrumens Sans',fontSize: 16,),),
                  ),
                  SizedBox(height: 6,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text('Where every Workout pushes you further',softWrap:true,maxLines:2,style: TextStyle(color: Colors.white,fontSize: 24,fontFamily: 'Instrument Sans'),),
                  ),
                  SizedBox(height: 24,),
                  Row(mainAxisAlignment:MainAxisAlignment.start,children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: InkWell(
                        onTap: (){
                          Get.offAllNamed(Routes.SIGNUP);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xffCFED51),
                            borderRadius: BorderRadius.circular(41),

                          ),child:Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 10),
                          child: Text('Sign Up',style: TextStyle(color: Colors.black,fontFamily: 'Instrument Sans',fontSize: 18,fontWeight: FontWeight.w700)),
                        ),
                        ),
                      ),
                    ),
                    SizedBox(width: 17,),
                    InkWell(
                      onTap: (){
                        Get.offAllNamed(Routes.LOGIN);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1,color: Color(0xffCFED51)),
                          borderRadius: BorderRadius.circular(41),

                        ),child:Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0,vertical: 10),
                        child: Text('Sign In',style: TextStyle(color: Color(0xffCFED51),fontFamily: 'Instrument Sans',fontSize: 18,fontWeight: FontWeight.w700),),
                      ),
                      ),
                    ),
                  ],),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}
