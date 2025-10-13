import 'package:flutter/cupertino.dart';
import 'package:flyconnect/screens/authentication/signup_screen.dart';
import 'package:flyconnect/screens/onboarding_screens/onboarding_screen.dart';

import 'routes.dart';

class Appages {
  static Map<String, WidgetBuilder> routes = {
    Routes.onboarding: (context) => const OnboardingScreen(),
    Routes.signup: (context) => const SignupScreen(),
  };
}
