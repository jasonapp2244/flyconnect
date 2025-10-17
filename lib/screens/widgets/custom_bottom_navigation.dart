import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/screens/explore_screen.dart';
import 'package:flyconnect/screens/home/home_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyconnect/screens/messages/messages_screen.dart';
import 'package:flyconnect/screens/profile_screen.dart';
import 'package:flyconnect/screens/profile_swipe_screen.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    HomeScreen(),
    ExploreView(),
    ProfileSwipeScreen(),
    InboxScreen(),
    ProfileScreen(),
  ];

  final List<String> icons = [
    'assets/icons/home.svg',
    'assets/icons/explore.svg',
    'assets/icons/connections.svg',
    'assets/icons/messenger.svg',
    'assets/icons/profile.svg',
  ];

  final List<String> labels = [
    "Home",
    "Explore",
    "Connections",
    "Messenger",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex], // ✅ show selected screen
      bottomNavigationBar: Container(
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(0, -2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(icons.length, (index) {
            final isSelected = selectedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() => selectedIndex = index); // ✅ change page
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 42,
                    height: 42,

                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: SvgPicture.asset(icons[index]),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    labels[index],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
