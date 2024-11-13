import 'package:flutter/material.dart';

class CostumTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final double height;
  final Widget? suffixIcon;
  CostumTextField(
      {super.key,
      required this.controller,
      this.height = 44,
      this.suffixIcon,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        obscureText: obscureText,
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          filled: true,
          fillColor: Colors.grey.shade200,
          border: InputBorder.none,
          suffixIcon: suffixIcon,
        ),
        controller: controller,
      ),
    );
  }
}
