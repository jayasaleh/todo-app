import 'package:flutter/material.dart';
import 'package:to_do/utils/app_styles.dart';

class CommonTextField extends StatelessWidget {
  const CommonTextField({
    super.key,
    required this.hintText,
    required this.textInputType,
    this.obscureText = false, // Ubah dari bool? ke bool dengan default false
    required this.controller, // Ubah dari optional ke required
    this.suffixIcon,
  });

  final String hintText;
  final TextInputType textInputType;
  final bool obscureText;
  final TextEditingController controller;
  final Widget? suffixIcon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: textInputType,
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppStyles.normalTextStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
        suffixIcon: suffixIcon,
      ),
    );
  }
}
