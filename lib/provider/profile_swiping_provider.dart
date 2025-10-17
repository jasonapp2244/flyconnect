import 'dart:async';
import 'package:flutter/material.dart';

class ProfileSwipeProvider with ChangeNotifier {
  late final PageController pageController;
  late final AnimationController progressController;

  int currentPage = 0;
  Timer? _timer;

  final List<Map<String, dynamic>> profiles = [
    {
      'name': 'Lily',
      'age': 28,
      'airline': 'Emirates',
      'image': 'assets/images/david.png',
      'tags': ['Adventurous', 'Food & Drink', 'Musician'],
    },
    {
      'name': 'Joly',
      'age': 32,
      'airline': 'flydubai',
      'image': 'assets/images/joly.png',
      'tags': ['Adventurous', 'Food & Drink', 'Musician'],
    },
    {
      'name': 'David',
      'age': 42,
      'airline': 'Air Arabia',
      'image': 'assets/images/lilly.png',
      'tags': ['Adventurous', 'Food & Drink', 'Hiking'],
    },
  ];

  ProfileSwipeProvider(TickerProvider vsync) {
    pageController = PageController();
    progressController =
        AnimationController(vsync: vsync, duration: Duration(seconds: 5))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              goToNextCard();
            }
          });
    startTimer();
  }

  void startTimer() {
    progressController.forward(from: 0);
    _timer?.cancel();
    _timer = Timer(Duration(seconds: 5), goToNextCard);
  }

  void goToNextCard() {
    if (currentPage < profiles.length - 1) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      pageController.jumpToPage(0);
    }
  }

  void onPageChanged(int index) {
    currentPage = index;
    _timer?.cancel();
    progressController.stop();
    if (index < profiles.length) startTimer();
    notifyListeners();
  }

  @override
  void dispose() {
    _timer?.cancel();
    progressController.dispose();
    pageController.dispose();
    super.dispose();
  }
}
