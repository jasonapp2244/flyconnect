import 'dart:async';
import 'package:flutter/material.dart';

import 'package:flyconnect/screens/get_started_splash_screen.dart'; // <-- replace with your actual next screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // ⏳ Wait for 3 seconds, then navigate
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const GetStartedSplashScreen(),
        ), // <-- your next page
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/flyconnect.png',
            color: Color(0xFFFFFFFF), // fixed correct color code
          ),
        ),
      ),
    );
  }
}
