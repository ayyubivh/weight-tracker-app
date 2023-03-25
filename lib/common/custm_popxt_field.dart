import 'package:flutter/material.dart';

class CustmPopupTxtField extends StatelessWidget {
  final TextEditingController controller;
  const CustmPopupTxtField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(color: Colors.black, fontSize: 20),
      textAlignVertical: TextAlignVertical.bottom,
      controller: controller,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 2.0, color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(16.0),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none),
        filled: true,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        fillColor: Colors.grey[200],
        hintText: "Weight",
        hintStyle: const TextStyle(
            letterSpacing: 1,
            color: Colors.grey,
            fontSize: 16.0,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}
