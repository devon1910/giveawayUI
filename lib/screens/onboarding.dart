import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giveawayui/screens/landing_screen.dart';
import 'package:giveawayui/screens/sign_in_screen.dart';
import 'package:giveawayui/size_config.dart';
import 'package:get/get.dart';

import '../constants.dart';
import '../components/DefaultButton.dart';
import '../components/SplashContent.dart';

class OnBoarding extends StatefulWidget {
  static String routeName="/onboarding";
  @override
  _OnBoardingState createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {

  int currentPage=0;
  List<Map<String, String>> splashData = [
    {
      "subtext": "Welcome",
      "subtextContent": "Manage all your crypto assets! \n it\'s simple and easy!",
      "image": "assets/grow.png",
    },
    {
      "subtext": "Spray",
      "subtextContent": "Spray money and crypto \n at events",
      "image": "assets/social.png",
    },
    {
      "subtext": "Redeem",
      "subtextContent": "Redeem airtime, crypto and \n mobile money",
      "image": "assets/onboad1.png",
    }
  ];
  PageController controller = PageController(initialPage: 0, keepPage: true);
  @override
  Widget build(BuildContext context) {
    SizeConfig.init(Get.context!);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              Expanded(
                  flex: 5,
                  child: PageView.builder(
                    controller: controller,
                      onPageChanged: (value){
                        setState(() {
                          currentPage= value;
                        });
                      },
                      itemCount: splashData.length,
                      itemBuilder: (context, index) => SplashContent(
                          subtext: splashData[index]["subtext"],
                          subtextContent: splashData[index]["subtextContent"],
                          image: splashData[index]["image"]))),
              Expanded(
                flex: 2,
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal:getProportionateScreenWidth(60)),
                  child: Column(
                    children: <Widget>[
                      Spacer(),
                      DefaultButton(
                        text:  currentPage == splashData.length-1 ?
                        "Get started" : "Next",
                        press:  () => changeSlide(context, currentPage+1),
                      ),
                      Spacer(flex: 1),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            splashData.length, (index) => buildDot(index: index)),
                      ),
                      Spacer()
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
}
  void changeSlide(context, index) {

    if(currentPage != splashData.length - 1) {
        controller.animateToPage(index, duration: Duration(milliseconds: 500),
            curve: Curves.easeIn);
        return;
    }

    generalAppSettings.updateSettings(setting: {"onBoarding": false});
    Get.offAllNamed(LandingScreen.routeName);

  }

  Container buildDot({required int index}) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: 14,
      width:  14,
      decoration: BoxDecoration(
        border: currentPage==index ? Border.all(
            style: BorderStyle.solid,
            width: 2.0,
            color: Color(0xFFFD749B)) : null,
        color: currentPage==index ? Colors.white : Colors.green,
        gradient: currentPage==index ?
        LinearGradient(colors: [Color(0xFFFFFF), Color(0xFFFFFF)]): circleStyle,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
