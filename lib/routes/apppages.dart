import 'package:flutter/cupertino.dart';
import 'package:flyconnect/screens/authentication/login_screen.dart';
import 'package:flyconnect/screens/authentication/signup_screen.dart';
import 'package:flyconnect/screens/onboarding_screens/get_started_screen.dart';
import 'package:flyconnect/screens/onboarding_screens/onboarding_screen.dart';

import 'routes.dart';

class Appages {
  static Map<String, WidgetBuilder> routes = {
    Routes.onboarding: (context) => const OnboardingScreen(),
    Routes.signup: (context) => SignUpScreen(),
    Routes.home: (context) => LoginScreen(),
    Routes.getStarted: (context) => GetStartedScreen(),
    Routes.login: (context) => LoginScreen(),
  };
}
