import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CostumTextField extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final double height;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  const CostumTextField({
    super.key,
    required this.controller,
    this.height = 44,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        style: GoogleFonts.nunitoSans(fontSize: 20, color: Colors.black87),
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
