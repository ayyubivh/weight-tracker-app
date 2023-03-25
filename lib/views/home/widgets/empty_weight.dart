import 'package:flutter/material.dart';
import 'package:weight_management_app/views/home/screens/home_screen.dart';

import '../../../core/colors/colors.dart';
import 'home_widgets.dart';

class EmptyWeights extends StatelessWidget {
  const EmptyWeights({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              iconSize: 70,
              onPressed: () {
                showAddWeightForm(context);
              },
              icon: const Icon(Icons.add_circle_outline_outlined)),
          Text(
            " Create Record",
            style: TextStyle(
              color: primaryColor.withOpacity(0.8),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
