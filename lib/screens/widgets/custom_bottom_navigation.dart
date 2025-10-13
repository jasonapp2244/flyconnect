import 'package:flutter/material.dart';
import 'package:flyconnect/screens/home/home_screen.dart';

class CustomBottomNavBar extends StatefulWidget {
  const CustomBottomNavBar({super.key});

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    HomeScreen(),
    const Center(child: Text('Explore Screen', style: TextStyle(fontSize: 22))),
    const Center(
      child: Text('Connections Screen', style: TextStyle(fontSize: 22)),
    ),
    const Center(
      child: Text('Messenger Screen', style: TextStyle(fontSize: 22)),
    ),
    const Center(child: Text('Profile Screen', style: TextStyle(fontSize: 22))),
  ];

  final List<IconData> icons = [
    Icons.flight,
    Icons.public,
    Icons.people_alt,
    Icons.message,
    Icons.person,
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
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
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
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.amber : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icons[index],
                      color: isSelected ? Colors.black : Colors.black54,
                      size: 26,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    labels[index],
                    style: TextStyle(
                      fontSize: 12,
                      color: isSelected ? Colors.black : Colors.black54,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
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
