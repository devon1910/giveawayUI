import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/colors.dart';
import '../size_config.dart';
import '/components/settings.dart';
import '/components/spray.dart';
import '/screens/all_events.dart';

class Dashboard extends StatelessWidget {
  static String routeName = "/dashboard";

  RxInt _bottomNavIndex = 0.obs;

  var iconList = [
    Icons.account_balance_wallet_outlined,
    Icons.settings
  ];

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(Get.context!);
    return Obx(() => Scaffold(
          body: IndexedStack(
            index: _bottomNavIndex.value,
            children: [Spray(), Settings()],
          ), //destination screen
          floatingActionButton: FloatingActionButton(
            mini: true,
            onPressed: () => Get.to(
              () => AllEvents(),
            ),
            backgroundColor: white,
            child: Image.asset(
              'assets/Group.png',
              scale: .2,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: AnimatedBottomNavigationBar(
            icons: iconList,
            iconSize: 30,
            activeIndex: _bottomNavIndex.value,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            leftCornerRadius: 20,
            rightCornerRadius: 20,
            onTap: changePage,
            inactiveColor: green.withOpacity(.8),
            activeColor: darkGreen,
            //other params
          ),
        ));
     }

  changePage(page) {
    print(page);
    _bottomNavIndex.value = page;
  }
}
