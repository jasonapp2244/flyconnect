import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/routes/routes.dart';
import 'package:flyconnect/screens/widgets/custom_button.dart';
import 'package:flyconnect/utils/responsive.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class GetStartedSplashScreen extends StatelessWidget {
  const GetStartedSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: ColorConstraint.yellowColor,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: _buildMainContent(context)),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  /// Main content: logo, text, button, and sign-in row
  Widget _buildMainContent(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLogo(),
        SizedBox(height: Responsive.h(5)),
        _buildTagline(),
        SizedBox(height: Responsive.h(2)),
        _buildGetStartedButton(context),
        SizedBox(height: Responsive.h(1)),
        _buildSignInRow(),
      ],
    );
  }

  /// App logo widget
  Widget _buildLogo() {
    return Image.asset('assets/images/flyconnect.png', color: Colors.white);
  }

  /// Tagline text
  Widget _buildTagline() {
    return Text(
      'Discover, Connect, Wander Together.',
      style: TextStyle(
        color: Colors.white,
        fontSize: Responsive.sp(13),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  /// "Get Started" button
  Widget _buildGetStartedButton(BuildContext context) {
    return CustomButton(
      width: 200,
      title: 'Get Started',
      bgColor: ColorConstraint.primaryColor,
      textColor: ColorConstraint.secondaryColor,
      onPressed: () {
        Navigator.pushNamed(context, Routes.onboarding);
      },
    );
  }

  /// "Already joined? Sign in" row
  Widget _buildSignInRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Already joined? ',
          style: TextStyle(
            color: ColorConstraint.whiteColor,
            fontSize: Responsive.sp(13),
            height: 1.5,
          ),
        ),
        Text(
          'Sign in',
          style: TextStyle(
            color: ColorConstraint.yellowColor,
            fontSize: Responsive.sp(13),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  /// Footer text with Terms & Privacy links
  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40.0),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'By tapping Get started, you agree with our ',
          style: TextStyle(
            color: ColorConstraint.whiteColor,
            fontSize: Responsive.sp(10),
            height: 1.5,
          ),
          children: [
            TextSpan(
              text: 'Terms',
              style: TextStyle(
                color: ColorConstraint.yellowColor,
                fontWeight: FontWeight.bold,
                fontSize: Responsive.sp(10),
              ),
            ),
            TextSpan(
              text: '\nSee how we process data in our ',
              style: TextStyle(
                color: ColorConstraint.whiteColor,
                fontSize: Responsive.sp(10),
                height: 1.5,
              ),
            ),
            TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(
                color: ColorConstraint.yellowColor,
                fontWeight: FontWeight.bold,
                fontSize: Responsive.sp(10),
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  print('Privacy Policy clicked');
                },
            ),
            const TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }
}
