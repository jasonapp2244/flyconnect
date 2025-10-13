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

  const CustomButton({
    super.key,
    required this.title,
    required this.bgColor,
    required this.onPressed,
    this.textColor,
    this.borderRadius = 12,
    this.fontSize = 16,
    this.height = 40,
    this.width,
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
