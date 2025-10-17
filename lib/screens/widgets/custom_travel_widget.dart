import 'dart:ui';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flyconnect/utils/responsive.dart';

class CustomTravelPostWidget extends StatelessWidget {
  final String name;
  final String location;
  final String profileImage;
  final String postImage;
  final String title;
  final String description;
  final VoidCallback onMenuTap;

  const CustomTravelPostWidget({
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
        Text(
          name,
          style: TextStyle(
            color: Colors.cyanAccent,
            fontSize: Responsive.sp(20),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          location,
          style: TextStyle(
            color: ColorConstraint.whiteColor,
            fontSize: Responsive.sp(13),
          ),
        ),
        const SizedBox(height: 16),

        // 🔹 Post Image Card
        Stack(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  18,
                ), // match the ClipRRect radius
                border: Border.all(
                  color: Colors.red, // border color
                  width: 6, // border thickness
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12), // same radius
                child: Image.asset(postImage, fit: BoxFit.cover),
              ),
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
          style: TextStyle(
            color: ColorConstraint.primaryColor,
            fontSize: Responsive.sp(20),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: TextStyle(
            color: Colors.white,
            fontSize: Responsive.sp(13),
            height: 1.4,
          ),
        ),
        const SizedBox(height: 14),

        // 🔹 Like / Comment / Share
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _PostAction(iconPath: 'assets/icons/like.svg', label: 'Like'),
            SizedBox(width: 20),
            _PostAction(iconPath: 'assets/icons/comment.svg', label: 'Comment'),
            SizedBox(width: 20),
            _PostAction(iconPath: 'assets/icons/share.svg', label: 'Share'),
          ],
        ),
      ],
    );
  }
}

class _PostAction extends StatelessWidget {
  final String iconPath;
  final String label;
  const _PostAction({required this.iconPath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(iconPath, color: Colors.white70),
        const SizedBox(width: 5),
        Text(
          label,
          style: TextStyle(color: ColorConstraint.whiteColor, fontSize: 14),
        ),
      ],
    );
  }
}
