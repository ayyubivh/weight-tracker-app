import 'package:flutter/material.dart';

import '../colors/colors.dart';

class CustomTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  final Icon? prefix;
  final String hinTtext;
  final int maxlines;
  final bool obscure;
  const CustomTextField({
    super.key,
    this.text = '',
    required this.controller,
    required this.hinTtext,
    this.maxlines = 1,
    this.prefix,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: primaryColor),
        decoration: InputDecoration(
          hintStyle: const TextStyle(
            color: Colors.black38,
            fontWeight: FontWeight.w400,
          ),
          prefixIconColor: primaryColor,
          hintText: hinTtext,
          prefixIcon: prefix,
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 2),
              borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 2),
              borderRadius: BorderRadius.circular(15)),
        ),
        obscureText: obscure,
        validator: (val) {
          if (val == null || val.isEmpty) {
            return 'Enter your $hinTtext';
          }
          return null;
        },
        maxLines: maxlines,
      ),
    );
  }
}
