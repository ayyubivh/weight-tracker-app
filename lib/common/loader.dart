import 'package:flutter/material.dart';
import 'package:weight_management_app/core/colors/colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: CircularProgressIndicator(
      color: primaryColor,
    ));
  }
}
