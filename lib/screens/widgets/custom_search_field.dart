import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchField extends StatelessWidget {
  final String? hintTitle;
  final String? imgPath;

  CustomSearchField({required this.hintTitle, this.imgPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Stack(
        children: [
          // Centered hint text
          Center(
            child: TextField(
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
                hintText: hintTitle,
                hintStyle: TextStyle(color: Colors.white70, fontSize: 16),
                border: InputBorder.none,
              ),
            ),
          ),

          // Positioned icon on the right
          if (imgPath != null)
            Positioned(
              right: 40, // distance from the right edge
              top: 9, // vertically center it inside 38 height (38 - 20) / 2 = 9
              child: SvgPicture.asset(
                imgPath!,
                color: Colors.white,
                width: 26,
                height: 20,
              ),
            ),
        ],
      ),
    );
  }
}
