import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../home/homescreenview.dart';
import '../profile/profileview.dart';
import '../progressbar/progressview.dart';
import 'bottomnavbarcontroller.dart';

class Bottomnavbarview extends StatelessWidget {
  final Bottomnavbarcontroller mainController = Get.put(Bottomnavbarcontroller());

  final pages = [
    Homescreenview(),
    Progressview(),
    Profileview(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() => pages[mainController.currentIndex.value]),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, left: 20, right: 20),
          child: Obx(
                () => ClipRRect(
    borderRadius: BorderRadius.circular(59,
              ),
                  child: Container(
                    height: 70,
                decoration: BoxDecoration(
                  color: Color(0xff2F2F2F),
                  borderRadius: BorderRadius.circular(59),),
                    child: SalomonBottomBar(
                                  currentIndex: mainController.currentIndex.value,
                                  onTap: (index) {
                    mainController.changeTab(index);
                                  },
                                  items: [
                    SalomonBottomBarItem(selectedColor: Colors.black,
                      icon: Image.asset(
                        'assets/images/homeinactive.png',
                        height: 24,
                        width: 24,
                      ),
                      activeIcon: Image.asset(
                        'assets/images/home.png',
                        height: 24,
                        width: 24,
                      ),
                      title: Text(
                        'Home',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: Color(0xffCFED51)),
                      ),
                    ),
                    SalomonBottomBarItem(
                      icon: Image.asset(
                        'assets/images/progress.png',
                        height: 24,
                        width: 24,
                      ),
                      activeIcon: Image.asset(
                        'assets/images/progressactive.png',
                        height: 24,
                        width: 24,
                      ),
                      title: Text(
                        'Progress',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: Color(0xffCFED51)),
                      ),
                    ),
                    SalomonBottomBarItem(
                      icon: Image.asset(
                        'assets/images/profile.png',
                        height: 24,
                        width: 24,
                      ),
                      activeIcon: Image.asset(
                        'assets/images/profileactive.png',
                        height: 24,
                        width: 24,
                      ),
                      title: Text(
                        'Profile',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500,color: Color(0xffCFED51)),
                      ),
                    ),
                                  ],
                                  backgroundColor: Colors.transparent,
                                  selectedItemColor: Colors.black,
                                  unselectedItemColor: Colors.white,
                                  selectedColorOpacity: 0.7,
                                  itemShape: StadiumBorder(),
                                  margin: EdgeInsets.all(8),
                                  itemPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 28),
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeOutQuint,
                                )
                  )
                )
          )
        )
      )
    );
  }
}

