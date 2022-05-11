import 'package:flutter/widgets.dart';
import '/screens/Transactions.dart';
import '/screens/amount.dart';
import '/screens/confirm_pin.dart';
import '/screens/confirm_pin2.dart';
import '/screens/create_event.dart';
import '/screens/dashboard.dart';
import '/screens/event_code.dart';
import '/screens/event_details.dart';
import '/screens/forgot_password.dart';
import '/screens/landing_screen.dart';
import '/screens/onboarding.dart';
import '/screens/otp.dart';
import '/screens/receive.dart';
import '/screens/updateProfile.dart';
import '/screens/sign_in_screen.dart';
import '/screens/sign_up_screen.dart';
import '/screens/spray_amount.dart';
import 'components/loadDash.dart';

// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  OnBoarding.routeName: (context) => OnBoarding(),
 // SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  LandingScreen.routeName: (context) => LandingScreen(),
  ForgotPassword.routeName: (context) => ForgotPassword(),
  Otp.routeName: (context) => Otp(),
  Dashboard.routeName: (context) => Dashboard(),
  Transactions.routeName: (context) => Transactions(),
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
  UpdateProfile.routeName: (context) => UpdateProfile(token: '', icon: IconData(0), parameter: '',),
  LoadDash.routeName: (context) => LoadDash(),
  EventCode.routeName: (context) => EventCode(allEvents: '', token: '',),
};