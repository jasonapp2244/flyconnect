import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final Color bgColor;
  final VoidCallback onPressed;
  final Color? textColor;
  final double borderRadius;
  final double fontSize;
  final double height;
  final double? width;

  // 👇 new optional border properties
  final Color? borderColor;
  final double borderWidth;

  const CustomButton({
    super.key,
    required this.title,
    required this.bgColor,
    required this.onPressed,
    this.textColor,
    this.borderRadius = 12,
    this.fontSize = 14,
    this.height = 40,
    this.width,
    this.borderColor,       // optional
    this.borderWidth = 1.5, // optional default
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: borderColor != null
                ? BorderSide(color: borderColor!, width: borderWidth)
                : BorderSide.none, // 👈 only show border if color provided
          ),
          elevation: 3,
        ),
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
