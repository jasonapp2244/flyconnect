import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/screens/widgets/custom_button.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstraint.yellowColor,
      body: Container(
        width: double.infinity,

        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/travel_bg.jpg'),
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
              'Embark on a Journey',
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Connect with like-minded explorers for unforgettable adventures.\nYour next travel companion is just a click away!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 40), // 👈 space before button
            CustomButton(
              width: 120,
              title: 'Next',
              bgColor: ColorConstraint.primaryColor,
              textColor: ColorConstraint.secondaryColor,
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
            ),
          ],
        ),
      ),
    );
  }
}
