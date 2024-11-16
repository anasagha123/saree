import 'package:flutter/material.dart';

import '../../config/responsive_font.dart';
import '../../config/theme.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String? Function(String?)? validator;
  final TextInputType? keyBoardType;
  final String? hint;
  final bool obscureText;

  const MyTextFormField({
    required this.controller,
    required this.icon,
    this.obscureText = false,
    this.validator,
    this.keyBoardType,
    this.hint,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (form) => TextFormField(
        obscureText: obscureText,
        keyboardType: keyBoardType,
        controller: controller,
        decoration: inputDecoration(
          icon: icon,
          hint: hint,
        ),
        validator: validator,
        style: TextStyle(fontSize: getResponsiveFontSize(context, 18)),
      ),
    );
  }
}

InputDecoration inputDecoration({required IconData icon, String? hint}) =>
    InputDecoration(
      fillColor: Colors.white,
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey),
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: MyTheme.primary),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: MyTheme.primary),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: MyTheme.primary),
      ),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon),
              const VerticalDivider(color: Colors.black),
            ],
          ),
        ),
      ),
    );
