import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flyconnect/const/colorconstraint.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.blue[900],

      // 🔹 Drawer
      drawer: Drawer(
        backgroundColor: ColorConstraint.redColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: ColorConstraint.redColor),
              child: Text(
                'FlyConnect Menu',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(Icons.explore),
              title: Text(
                'Explore',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(Icons.people_alt),
              title: Text(
                'Connections',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                'Settings',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TravelPostWidget(
                name: "Joanna Doe",
                location: "Currently in Stockholm",
                profileImage: "assets/images/joana_avatar.png",
                postImage: "assets/images/tale.png",
                title: "My favorite travel memory..",
                description:
                    "Wandering through the narrow streets of Kyoto during the cherry blossom season, a surreal blend of tradition and nature.",
                onMenuTap: () {
                  _scaffoldKey.currentState?.openDrawer(); // 👈 Opens drawer
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TravelPostWidget extends StatelessWidget {
  final String name;
  final String location;
  final String profileImage;
  final String postImage;
  final String title;
  final String description;
  final VoidCallback onMenuTap;

  const TravelPostWidget({
    super.key,
    required this.name,
    required this.location,
    required this.profileImage,
    required this.postImage,
    required this.title,
    required this.description,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 🔹 Top Row: Logo + Icons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/flyconnect.png',
              width: 100,
              height: 100,
            ),
            Row(
              children: [
                SvgPicture.asset('assets/icons/notification.svg'),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: onMenuTap,
                  child: SvgPicture.asset('assets/icons/hamburger.svg'),
                ),
              ],
            ),
          ],
        ),

        Text(
          name,
          style: const TextStyle(
            color: Colors.cyanAccent,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          location,
          style: const TextStyle(color: Colors.white70, fontSize: 16),
        ),
        const SizedBox(height: 16),

        // 🔹 Post Image Card
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(postImage, fit: BoxFit.cover),
            ),
            Positioned(
              left: 10,
              top: 10,
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(profileImage),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // 🔹 Caption
        Text(
          title,
          style: const TextStyle(
            color: Colors.cyanAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14),

        // 🔹 Like / Comment / Share
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            _PostAction(icon: Icons.thumb_up_alt_outlined, label: 'Like'),
            _PostAction(icon: Icons.comment_outlined, label: 'Comment'),
            _PostAction(icon: Icons.share_outlined, label: 'Share'),
          ],
        ),
      ],
    );
  }
}

class _PostAction extends StatelessWidget {
  final IconData icon;
  final String label;
  const _PostAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.white70, size: 20),
        const SizedBox(width: 5),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ],
    );
  }
}
