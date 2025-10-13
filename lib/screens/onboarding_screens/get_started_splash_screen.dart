import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/routes/routes.dart';
import 'package:flyconnect/screens/widgets/custom_button.dart';

class GetStartedSplashScreen extends StatelessWidget {
  const GetStartedSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstraint.yellowColor,
      body: Container(
        width: double.infinity,

        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/flyconnect.png',
                    color: Colors.white,
                  ),
                  SizedBox(height: 40),
                  const Text(
                    'Discover, Connect, Wander Together.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 26),
                  CustomButton(
                    width: 160,
                    title: 'Get Started',
                    bgColor: ColorConstraint.primaryColor,
                    textColor: ColorConstraint.secondaryColor,
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.onboarding);
                    },
                  ),
                  const SizedBox(height: 17),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already joined? ',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                      Text(
                        ' Sign In',
                        style: TextStyle(
                          color: ColorConstraint.yellowColor,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Footer stays at bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'By tapping Get started, you agree with our ',
                  style: TextStyle(
                    color: ColorConstraint.whiteColor,
                    fontSize: 13,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(
                      text: 'Terms',
                      style: TextStyle(
                        color: ColorConstraint.yellowColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(
                      text: '\nSee how we process data in our ',
                      style: TextStyle(
                        color: ColorConstraint.whiteColor,
                        fontSize: 13,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: ColorConstraint.yellowColor,
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('Privacy Policy clicked');
                        },
                    ),
                    TextSpan(text: '.'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
