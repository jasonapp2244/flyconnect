import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/routes/routes.dart';
import 'package:flyconnect/screens/widgets/custom_button.dart';
import 'package:flyconnect/utils/responsive.dart';

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
          'Connect with like-minded explorers for\nunforgettable adventures. Your next travel\ncompanion is just a click away.',
      'path': 'assets/images/embark_journey.png',
    },
    {
      'title': 'Seamless Connections',
      'subtitle':
          'Chat, plan, and explore effortlessly with your travel companions.\nYour next adventure begins with a simple message.',
      'path': 'assets/images/seamless.png',
    },
    {
      'title': 'Craft Your Journey',
      'subtitle':
          'Build your itinerary collaboratively with fellow travelers.\nTurn plans into unforgettable experiences together.',
      'path': 'assets/images/craft_journey.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: ColorConstraint.whiteColor,
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
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
            _buildPageView(),
            const SizedBox(height: 20),
            _buildDotIndicator(),
            const SizedBox(height: 24),
            _buildNextButton(context),
          ],
        ),
      ),
    );
  }

  // -------------------------------
  // 🧩 WIDGET METHODS
  // -------------------------------

  /// PageView with title + subtitle
  Widget _buildPageView() {
    return SizedBox(
      height: Responsive.h(28),
      child: PageView.builder(
        controller: _pageController,
        itemCount: pages.length,
        onPageChanged: (index) {
          setState(() => _currentPage = index);
        },
        itemBuilder: (context, index) {
          return _buildOnboardContent(
            title: pages[index]['title']!,
            subtitle: pages[index]['subtitle']!,
          );
        },
      ),
    );
  }

  /// Single page content
  Widget _buildOnboardContent({
    required String title,
    required String subtitle,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.sp(20),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: ColorConstraint.whiteColor,
            fontSize: Responsive.sp(12),
            height: 1.5,
          ),
        ),
      ],
    );
  }

  /// Dot indicator below the PageView
  Widget _buildDotIndicator() {
    return Row(
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
    );
  }

  /// "Next" button at the bottom
  Widget _buildNextButton(BuildContext context) {
    return CustomButton(
      width: 140,
      title: _currentPage == pages.length - 1 ? 'Get Started' : 'Next',
      bgColor: ColorConstraint.primaryColor,
      textColor: ColorConstraint.secondaryColor,
      onPressed: () {
        if (_currentPage < pages.length - 1) {
          _pageController.nextPage(
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        } else {
          Navigator.pushNamed(context, Routes.getStarted);
        }
      },
    );
  }
}
