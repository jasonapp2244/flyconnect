import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/routes/routes.dart';
import 'package:flyconnect/screens/widgets/custom_button.dart';
import 'package:flyconnect/screens/widgets/custom_textfield.dart';
import 'package:flyconnect/utils/responsive.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
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
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: Responsive.sp(13),
                    ),
                  ),
                  SizedBox(height: 5),
                  CustomTextField(
                    label: 'Email',
                    icon: Icons.email_outlined,
                    controller: _emailController,
                  ),
                  SizedBox(height: Responsive.h(1)),
                  Text(
                    'Password',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.6),
                      fontSize: Responsive.sp(13),
                    ),
                  ),
                  SizedBox(height: 5),

                  CustomTextField(
                    label: 'Password',
                    icon: Icons.lock_outline,
                    controller: _passwordController,
                    suffixIcon: Icons.visibility,
                  ),
                  SizedBox(height: Responsive.h(2)),
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
                  SizedBox(height: Responsive.h(4)),
                  CustomButton(
                    title: 'Log In',
                    textColor: ColorConstraint.secondaryColor,
                    bgColor: ColorConstraint.primaryColor,
                    onPressed: () {
                      Navigator.pushNamed(context, Routes.home);
                    },
                  ),
                  SizedBox(height: Responsive.h(3)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Or Create account using social media',
                        style: TextStyle(
                          color: ColorConstraint.whiteColor,
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.h(3)),
                  buildSignInCard(
                    FontAwesomeIcons.google,
                    'Continue with Google',
                  ),
                  SizedBox(height: Responsive.h(2)),
                  buildSignInCard(
                    FontAwesomeIcons.apple,
                    'Continue with Apple',
                  ),
                  SizedBox(height: Responsive.h(2)),
                  buildSignInCard(
                    FontAwesomeIcons.facebook,
                    'Continue with Facebook',
                  ),
                ],
              ),
            ),
          ),
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
