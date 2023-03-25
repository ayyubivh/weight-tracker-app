import 'package:flutter/material.dart';

class CustomPopButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color txtColor;
  final Widget? loading;
  const CustomPopButton(
      {super.key,
      required this.text,
      required this.onTap,
      required this.color,
      required this.txtColor,
      this.loading});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.5),
            offset: const Offset(2, 2),
            blurRadius: 5,
          ),
        ],
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: color,
        ),
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
              color: txtColor),
        ),
      ),
    );
  }
}
