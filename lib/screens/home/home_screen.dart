import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              TravelPostWidget(
                name: "Joanna Doe",
                location: "Currently in Stockholm",
                profileImage: "assets/images/jaona.",
                postImage: "assets/images/travel.svg",
                title: "My favorite travel memory..",
                description:
                    "Wandering through the narrow streets of Kyoto during the cherry blossom season, a surreal blend of tradition and nature.",
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

  const TravelPostWidget({
    super.key,
    required this.name,
    required this.location,
    required this.profileImage,
    required this.postImage,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Row(children: []),
            Row(children: [Image.asset('assets/images/connect_logo.png')]),
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
              child: Image.asset('assets/images/tale.png', fit: BoxFit.cover),
            ),
            Positioned(
              left: 10,
              top: 10,
              child: CircleAvatar(
                radius: 20,
                child: Image.asset('assets/icons/joana_avatar.png'),
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
