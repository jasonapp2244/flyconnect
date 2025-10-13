import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/screens/widgets/custom_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Let’s Get Started!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: ColorConstraint.primaryColor,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Lorem Ipsum is simply dummy text',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: ColorConstraint.lightGrey,
              ),
            ),
            SizedBox(height: 40),
            buildSignInCard(FontAwesomeIcons.google, 'Continue with google'),
            SizedBox(height: 15),
            buildSignInCard(FontAwesomeIcons.apple, 'Continue with apple'),
            SizedBox(height: 15),
            buildSignInCard(
              FontAwesomeIcons.facebook,
              'Continue with facebook',
            ),
            SizedBox(height: 130),
            CustomButton(
              title: 'Sign Up',
              textColor: ColorConstraint.secondaryColor,
              bgColor: ColorConstraint.primaryColor,
              onPressed: () {},
            ),
            SizedBox(height: 15),
            CustomButton(
              title: 'Log In',
              textColor: ColorConstraint.secondaryColor,
              bgColor: ColorConstraint.whiteColor,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSignInCard(IconData icon, String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstraint.whiteColor),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: ColorConstraint.whiteColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
