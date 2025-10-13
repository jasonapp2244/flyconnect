import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"), // <-- your image path
            fit: BoxFit.cover, // covers full screen
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/images/flyconnect.png',
            color: Color(0xffffff),
          ),
        ),
      ),
    );
  }
}
