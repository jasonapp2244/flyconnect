import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/routes/routes.dart';
import 'package:flyconnect/screens/widgets/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> pages = [
    {
      'title': 'Embark on a Journey',
      'subtitle':
          'Connect with like-minded explorers for\n unforgettable adventures. Your next travel\n companion is just a click away',
      'path': 'assets/images/embark_journey.png',
    },
    {
      'title': 'Seamless Connections',
      'subtitle':
          'Chat, plan, and explore effortlessly with your travel companions. Your next adventure begins with a simple message',
      'path': 'assets/images/seamless.png',
    },
    {
      'title': 'Craft Your Journey',
      'subtitle':
          'Build your itinerary collaboratively with fellow travelers. Turn plans into unforgettable experiences together',
      'path': 'assets/images/craft_journey.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstraint.whiteColor,
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(pages[_currentPage]['path']!),
            fit: BoxFit.fill,
            alignment: Alignment.center,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.28,
              child: PageView.builder(
                controller: _pageController,
                itemCount: pages.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        pages[index]['title']!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        pages[index]['subtitle']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            // --- Dot Indicator ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                pages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 6),
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index <= _currentPage
                        ? ColorConstraint.yellowColor
                        : Colors.transparent,
                    border: Border.all(
                      color: index <= _currentPage
                          ? Colors.transparent
                          : ColorConstraint.whiteColor,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // --- NEXT BUTTON ---
            CustomButton(
              width: 120,
              title: 'Next',
              bgColor: ColorConstraint.primaryColor,
              textColor: ColorConstraint.secondaryColor,
              onPressed: () {
                if (_currentPage < pages.length - 1) {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Navigator.pushNamed(context, Routes.getStarted);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
