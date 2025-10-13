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
          mainAxisAlignment:
              MainAxisAlignment.end, // 👈 pushes content to bottom
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Discover, Connect, Wander Together.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40), // 👈 space before button
            CustomButton(
              width: 120,
              title: 'Get Started',
              bgColor: ColorConstraint.primaryColor,
              textColor: ColorConstraint.secondaryColor,
              onPressed: () {
                Navigator.pushNamed(context, Routes.onboarding);
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Text(
                  'Already joined ?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),

                Text(
                  'Sign In?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorConstraint.yellowColor,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
