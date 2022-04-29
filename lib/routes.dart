import 'package:flutter/widgets.dart';
import 'package:giveawayui/screens/Transactions.dart';
import 'package:giveawayui/screens/amount.dart';
import 'package:giveawayui/screens/confirm_pin.dart';
import 'package:giveawayui/screens/confirm_pin2.dart';
import 'package:giveawayui/screens/create_event.dart';
import 'package:giveawayui/screens/dashboard.dart';
import 'package:giveawayui/screens/event_code.dart';
import 'package:giveawayui/screens/event_details.dart';
import 'package:giveawayui/screens/forgot_password.dart';
import 'package:giveawayui/screens/landing_screen.dart';
import 'package:giveawayui/screens/onboarding.dart';
import 'package:giveawayui/screens/otp.dart';
import 'package:giveawayui/screens/receive.dart';
import 'package:giveawayui/screens/updateProfile.dart';
import 'package:giveawayui/screens/sign_in_screen.dart';
import 'package:giveawayui/screens/sign_up_screen.dart';
import 'package:giveawayui/screens/spray_amount.dart';

// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  OnBoarding.routeName: (context) => OnBoarding(),
 // SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  LandingScreen.routeName: (context) => LandingScreen(),
  ForgotPassword.routeName: (context) => ForgotPassword(),
  Otp.routeName: (context) => Otp(),
  Dashboard.routeName: (context) => Dashboard(token: '',trans: '',user: '',allEvents: '', userEvent: '',),
  Transactions.routeName: (context) => Transactions(trans:''),
  Receive.routeName: (context) => Receive(token: '',),
 // Send.routeName: (context) => Send(),
 // ScanScreen.routeName: (context) => ScanScreen(),
  Amount.routeName: (context) => Amount(),
  ConfirmPin.routeName: (context) => ConfirmPin(fullname: '',username: '',phone: '',
      email: '',password: ''),
  SprayAmount.routeName: (context) => SprayAmount(ecode: '',token: '',),
  ConfirmPin2.routeName: (context) => ConfirmPin2(fullname: '',username: '',
    email: '',password: '',pin: '',phone: ''),
  CreateEvent.routeName: (context) => CreateEvent(''),
  EventDetails.routeName: (context) => EventDetails(name: '',code: '',token: '',),
  EventCode.routeName: (context) => EventCode(allEvents: '', token: '',),
  UpdateProfile.routeName: (context) => UpdateProfile(token: '', icon: IconData(0), parameter: '',),
};