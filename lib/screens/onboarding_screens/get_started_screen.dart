import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/routes/routes.dart';
import 'package:flyconnect/screens/widgets/custom_button.dart';
import 'package:flyconnect/utils/responsive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      body: Container(
        height: Responsive.screenHeight, // 👈 full height
        width: double.infinity,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Let’s Get Started!',
                  style: TextStyle(
                    fontSize: Responsive.sp(20),
                    fontWeight: FontWeight.bold,
                    color: ColorConstraint.primaryColor,
                  ),
                ),
                SizedBox(height: Responsive.h(1)),
                Text(
                  'Lorem Ipsum is simply dummy text',
                  style: TextStyle(
                    fontSize: Responsive.sp(9),
                    fontWeight: FontWeight.w600,
                    color: ColorConstraint.lightGrey,
                  ),
                ),
                SizedBox(height: Responsive.h(5)),

                buildSignInCard(
                  'assets/icons/google.svg',
                  'Continue with google',
                ),
                SizedBox(height: Responsive.h(2)),
                buildSignInCard(
                  'assets/icons/apple.svg',
                  'Continue with apple',
                ),
                SizedBox(height: Responsive.h(2)),
                buildSignInCard(
                  'assets/icons/facebook.svg',
                  'Continue with facebook',
                ),

                SizedBox(height: Responsive.h(13)),
                CustomButton(
                  title: 'Sign Up',
                  textColor: ColorConstraint.secondaryColor,
                  bgColor: ColorConstraint.primaryColor,
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.signup);
                  },
                ),
                SizedBox(height: Responsive.h(2)),
                CustomButton(
                  title: 'Log In',
                  textColor: ColorConstraint.secondaryColor,
                  bgColor: ColorConstraint.whiteColor,
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.login);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignInCard(String imgPath, String text) {
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 24,
            width: 24,
            child: Center(
              child: SvgPicture.asset(imgPath, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              color: ColorConstraint.whiteColor,
              fontSize: Responsive.sp(13),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
