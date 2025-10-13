import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/routes/routes.dart';
import 'package:flyconnect/screens/widgets/custom_button.dart';
import 'package:flyconnect/screens/widgets/custom_textfield.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height, // ✅ Full height
          ),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/bg.png'),
                fit: BoxFit.cover, // ✅ Cover the full screen properly
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    label: 'Username',
                    icon: Icons.email_outlined,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'Email',
                    icon: Icons.email_outlined,
                    controller: _emailController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'Password',
                    icon: Icons.lock_outline,
                    controller: _passwordController,
                    suffixIcon: Icons.visibility,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Checkbox(
                            value: rememberMe,
                            onChanged: (value) {
                              setState(() {
                                rememberMe = value ?? false;
                              });
                            },
                            activeColor: ColorConstraint.whiteColor,
                            checkColor: ColorConstraint.primaryColor,
                            side: BorderSide(
                              color: ColorConstraint.primaryColor,
                              width: 1.5,
                            ),
                          ),
                          Text(
                            "Remember me",
                            style: TextStyle(
                              color: ColorConstraint.whiteColor.withOpacity(
                                0.8,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          print("Forgot password clicked");
                        },
                        child: Text(
                          "Forgot password?",
                          style: TextStyle(
                            color: ColorConstraint.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    title: 'Log In',
                    textColor: ColorConstraint.secondaryColor,
                    bgColor: ColorConstraint.primaryColor,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Or Create account using social media',
                    style: TextStyle(
                      color: ColorConstraint.whiteColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  buildSignInCard(
                    'assets/icons/google.svg',
                    'Continue with google',
                  ),
                  SizedBox(height: 15),
                  buildSignInCard(
                    'assets/icons/apple.svg',
                    'Continue with apple',
                  ),
                  SizedBox(height: 15),
                  buildSignInCard(
                    'assets/icons/facebook.svg',
                    'Continue with facebook',
                  ),
                ],
              ),
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
        crossAxisAlignment:
            CrossAxisAlignment.center, // ensures icon & text align vertically
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
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
