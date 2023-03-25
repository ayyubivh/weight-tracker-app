import 'package:flutter/material.dart';

class CustmPopupTxtField extends StatelessWidget {
  final TextEditingController controller;
  const CustmPopupTxtField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.5),
            offset: const Offset(4, 4),
            blurRadius: 6,
          ),
        ],
      ),
      child: TextFormField(
        style: const TextStyle(color: Colors.black, fontSize: 20),
        textAlignVertical: TextAlignVertical.bottom,
        controller: controller,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(30),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          fillColor: Colors.grey.shade300,
          hintText: "Weight",
          hintStyle: const TextStyle(
              letterSpacing: 1,
              color: Colors.grey,
              fontSize: 16.0,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
