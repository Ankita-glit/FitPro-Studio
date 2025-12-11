import 'package:firebase_auth/firebase_auth.dart';
import 'package:firstdayappsuccessor/screens/profile/profilecontroller.dart';
import 'package:firstdayappsuccessor/screens/profile/updationpages/updatedheight/heightpage.dart';
import 'package:firstdayappsuccessor/screens/profile/updationpages/updatedweight/weightpage.dart';
import 'package:firstdayappsuccessor/screens/profile/updationpages/namepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app_route/app_pages.dart';
import '../../helper/alertdialog/alertdialog.dart';
import '../../helper/drawer/drawer.dart';
import '../../helper/sharedprefrence/prefhandlerhome.dart';
import '../auth/loginsignup/signup/gender/gendercontroller.dart';

class Profileview extends StatelessWidget {
  Profileview({super.key});

  ProfileController controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0,right: 25,top: 58,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('PERSONAL',style: TextStyle(color: Color(0xffCFED51),fontWeight: FontWeight.w700,fontFamily: 'Instrument Sans',fontSize: 20),),
                SizedBox(height: 17,),
                Container(
                  height: Get.height*0.2,
                  child: drawerItems([
                    DrawerItem(
                        image: Image.asset('assets/images/username.png',height: 24,width: 24,),
                        context: context,
                        title: "Username",
                        onTap: () {
                          Get.to(ProfileNamepage(),transition: Transition.fadeIn);
                        }, trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,size: 20,),),
                    DrawerItem(
                        image: Image.asset('assets/images/weight.png',height: 24,width: 24,),
                        context: context,
                        title: "Change Weight",
                        onTap: () {
                           Get.to(WeightPage(),transition: Transition.fadeIn);
                        },trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,size: 20,),),
                    DrawerItem(
                        image: Image.asset('assets/images/height.png',height: 24,width: 24,),
                        context: context,
                        title: "Change Height",
                        onTap: () {
                          Get.to(Heightpage(),transition: Transition.fadeIn);
                        },trailing: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,size: 20,),),
                  ]),
                ),
                SizedBox(height: 18,),
                Text('REMINDERS',style: TextStyle(color: Color(0xffCFED51),fontWeight: FontWeight.w700,fontFamily: 'Instrument Sans',fontSize: 20),),
                SizedBox(height: 18,),
                DrawerItem(
                  image: Image.asset('assets/images/notification.png', height: 24, width: 24),
                  context: context,
                  title: "Daily Workout Reminder",
                  onTap: () {
                  },
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: Obx(
                            () => Transform.scale(
                          scale: 1.0,
                          child: Switch(
                            value: controller.isReminderEnabled.value,
                            onChanged: (bool newValue) {
                              controller.isReminderEnabled.value = newValue;
                            },
                            activeTrackColor: Color(0xffCFED51),
                            inactiveTrackColor: Colors.grey,
                            activeColor: Colors.black,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            inactiveThumbColor: Color(0xffCFED51),
                          )
                        )
                      )
                    )
                  )
                ),
                SizedBox(height: 29,),
                Text('OTHERS',style: TextStyle(color: Color(0xffCFED51),fontWeight: FontWeight.w700,fontFamily: 'Instrument Sans',fontSize: 20),),
                SizedBox(height: 8,),
                drawerItems([
                  DrawerItem(
                    image: Image.asset('assets/images/star.png',height: 24,width: 24,),
                    context: context,
                    title: "Rate The App",
                    onTap: () {
                    },),
                  DrawerItem(
                    image: Image.asset('assets/images/share.png',height: 24,width: 24,),
                    context: context,
                    title: "Share The App",
                    onTap: () {

                    },),
                  DrawerItem(
                    image: Image.asset('assets/images/privacy.png',height: 24,width: 24,),
                    context: context,
                    title: "Privacy Policy",
                    onTap: () {
                      controller.LaunchUrl();
                    },),
                  DrawerItem(
                    image: Image.asset('assets/images/logout.png',height: 24,width: 24,),
                    context: context,
                    title: "Log Out",
                    onTap: () {
                      CustomAlertDialog.showPresenceAlertL(
                          message:
                          "Are you sure you want to log out of your account?",
                          confirmText: "LOGOUT",
                          cancelText: "CANCEL",
                          context: context,
                          onCancel: () => Get.back(),
                          onConfirm: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await PrefHandler.init();
                            try {
                              await prefs.remove('Pushremovedlist');
                              await prefs.remove('Pullremovedlist');
                              await prefs.remove('Legsremovedlist');
                              await prefs.remove('chestWeightedList');
                              await prefs.remove('chestBodyWeightedList');
                              await prefs.remove('backWeightedList');
                              await prefs.remove('backBodyWeightedList');
                              await prefs.remove('legsWeightedList');
                              await prefs.remove('legsBodyWeightedList');
                              await PrefHandler.remove('isFirstLoad');
                              await FirebaseAuth.instance.signOut();

                              GoogleSignIn _googleSignIn = GoogleSignIn();
                              await _googleSignIn.signOut();
                              Get.offAllNamed(Routes.LOGIN);
                            } catch (e) {
                              print("Logout Error: $e");
                              Get.snackbar('Error', 'An error occurred during logout.',
                                  backgroundColor: Color(0xff2F2F2F), colorText: Colors.white);
                            }
                          });
                    },),
                  DrawerItem(
                    image: Image.asset('assets/images/deleteaccount.png',height: 24,width: 24,),
                    context: context,
                    title: "Delete Account",
                    onTap: () {
                      CustomAlertDialog.showPresenceAlertL(
                          message: "Are you sure you want to delete your account?",
                          confirmText: "DELETE",
                          cancelText: "CANCEL",
                          context: context,
                          onCancel: () => Get.back(),
                          onConfirm: () async{
                            Get.delete<GenderController>();
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await PrefHandler.init();
                            await prefs.remove('user_gender');
                            await prefs.remove('Pushremovedlist');
                            await prefs.remove('Pullremovedlist');
                            await prefs.remove('Legsremovedlist');
                            await prefs.remove('chestWeightedList');
                            await prefs.remove('chestBodyWeightedList');
                            await prefs.remove('backWeightedList');
                            await prefs.remove('backBodyWeightedList');
                            await prefs.remove('legsWeightedList');
                            await prefs.remove('legsBodyWeightedList');
                            await PrefHandler.remove('isFirstLoad');
                            controller.DeleteAccount(context);
                          }
                          );
                    },)
                ])

              ]
            )
          )
        )
      )
    );
  }

  SizedBox drawerItems(List<DrawerItem> list) {
    return SizedBox(
      height:280,
      child: ListView.separated(

        padding: EdgeInsets.zero,physics: NeverScrollableScrollPhysics(),
        itemCount: list.length,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox.shrink();
        },
        itemBuilder: (BuildContext context, int index) {
          return list[index];
        }
      )
    );
  }
}
