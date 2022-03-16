
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/components/settings.dart';
import 'package:giveawayui/components/spray.dart';
import 'package:giveawayui/screens/spray_amount.dart';
import 'package:giveawayui/size_config.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'create_event.dart';

class Dashboard extends StatefulWidget {
  Dashboard({required this.token,
    required this.trans,
  required this.user,
  required this.events});
  final String? token;
  final  trans,events,user;

  static String routeName="/dashboard";


  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  List<Widget> _buildScreens() {
    return [
      Spray(token: widget.token!,
        events: widget.events,
        user: widget.user,
        trans:widget.trans
      ),
      Settings()
    ];
  }
  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        // icon: Image.asset('assets/wallet.png',
        //   width: 400,
        //   height: 400,),
        icon: Icon(
          Icons.account_balance_wallet_outlined
        ),
        title: ("Wallet"),
        activeColorPrimary: Color.fromRGBO(52, 138, 199, 1.0),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
       // icon: Image.asset('assets/settings.png'),
        icon: Icon(
          Icons.settings_rounded
        ),
        title: ("Settings"),
        activeColorPrimary: Color.fromRGBO(52, 138, 199, 1.0),
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }
  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style6, // Choose the nav bar style with this property.
    );
  }
}


