import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:weight_management_app/core/colors/colors.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Shimmer.fromColors(
            baseColor: primaryColor.withOpacity(0.4),
            highlightColor: primaryColor.withOpacity(0.6),
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const SizedBox(height: 70),
                  ),
                );
              },
            )));
  }
}
