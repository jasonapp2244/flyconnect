import 'package:flutter/cupertino.dart';
import 'package:flyconnect/group_screen.dart';
import 'package:flyconnect/screens/authentication/login_screen.dart';
import 'package:flyconnect/screens/authentication/signup_screen.dart';
import 'package:flyconnect/screens/event_detail_screen.dart';
import 'package:flyconnect/screens/home/edit_profile_screen.dart';
import 'package:flyconnect/screens/onboarding_screens/get_started_screen.dart';
import 'package:flyconnect/screens/onboarding_screens/onboarding_screen.dart';
import 'package:flyconnect/screens/onboarding_screens/splash_screen.dart';
import 'package:flyconnect/screens/profile_swipe_screen.dart';
import 'package:flyconnect/screens/widgets/custom_bottom_navigation.dart';

import 'routes.dart';

class Appages {
  static Map<String, WidgetBuilder> routes = {
    Routes.onboarding: (context) => const OnboardingScreen(),
    Routes.signup: (context) => SignUpScreen(),
    Routes.home: (context) => CustomBottomNavBar(),
    Routes.getStarted: (context) => GetStartedScreen(),
    Routes.login: (context) => LoginScreen(),
    Routes.splash: (context) => SplashScreen(),
    Routes.group: (context) => GroupScreen(),
    Routes.editProfile: (context) => EditProfileScreen(),
    Routes.eventDetail: (context) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      return EventDetailScreen(
        title: args['title'],
        date: args['date'],
        description: args['description'],
        imagePath: args['imagePath'],
      );
    },
    Routes.profileSwipe: (context) => const ProfileSwipeScreen(),
  };
}
