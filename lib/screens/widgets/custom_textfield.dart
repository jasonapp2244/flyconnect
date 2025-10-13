import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';
import 'package:flutter/material.dart';
import 'package:flyconnect/const/colorconstraint.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextEditingController controller;
  final bool obscureText;
  final IconData? suffixIcon;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.icon,
    required this.controller,
    this.obscureText = false,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: ColorConstraint.whiteColor),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 15),

        labelText: label,
        labelStyle: TextStyle(color: ColorConstraint.whiteColor),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Icon(icon, color: ColorConstraint.whiteColor),
        ),
        filled: true,
        fillColor: Colors.transparent,
        suffixIcon: Icon(suffixIcon, color: ColorConstraint.whiteColor),

        // ✅ Enabled (default) border
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorConstraint.whiteColor, width: 1),
        ),

        // ✅ Focused border (when you tap the field)
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: ColorConstraint.whiteColor, width: 2),
        ),
      ),
    );
  }
}
