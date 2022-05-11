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
    // Column(children: [Icon(Icons.account_balance_wallet_outlined), Text("Wallet")]),
    // Column(children: [Icon(Icons.settings), Text("Settings")]),
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
            activeIndex: _bottomNavIndex.value,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.softEdge,
            leftCornerRadius: 20,
            rightCornerRadius: 20,
            onTap: changePage,
            inactiveColor: grey,
            activeColor: green,
            //other params
          ),
        ));
    // return PersistentTabView(
    //   context,
    //   controller: _controller,
    //   screens: _buildScreens(),
    //   items: _navBarsItems(),
    //   confineInSafeArea: true,
    //   backgroundColor: Colors.white, // Default is Colors.white.
    //   handleAndroidBackButtonPress: true, // Default is true.
    //   resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
    //   stateManagement: true, // Default is true.
    //   hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
    //   decoration: NavBarDecoration(
    //     borderRadius: BorderRadius.circular(10.0),
    //     colorBehindNavBar: Colors.white,
    //   ),
    //   popAllScreensOnTapOfSelectedTab: true,
    //   popActionScreens: PopActionScreensType.all,
    //   itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
    //     duration: Duration(milliseconds: 200),
    //     curve: Curves.ease,
    //   ),
    //   screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
    //     animateTabTransition: true,
    //     curve: Curves.ease,
    //     duration: Duration(milliseconds: 200),
    //   ),
    //   navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
    // );
  }

  changePage(page) {
    print(page);
    _bottomNavIndex.value = page;
  }
}
