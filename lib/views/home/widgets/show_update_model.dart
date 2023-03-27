import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/common/snackbar.dart';
import '../../../core/colors/colors.dart';
import '../../../core/consts.dart';
import '../../../provider/providers.dart';
import '../../../service/database_service.dart';
import '../screens/home_screen.dart';
import 'custm_popxt_field.dart';
import 'custom_pop_btn.dart';
import 'date_field.dart';

final TextEditingController weightController = TextEditingController();
final dateController = TextEditingController();

class ShowUpdateSheet extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final passValue;
  // ignore: prefer_typing_uninitialized_variables
  final passIndex;
  const ShowUpdateSheet(this.passValue, this.passIndex, {super.key});

  @override
  State<ShowUpdateSheet> createState() => _ShowUpdateSheetState();
}

class _ShowUpdateSheetState extends State<ShowUpdateSheet> {
  @override
  void initState() {
    super.initState();
    weightController.text = getWeight(widget.passValue[widget.passIndex]);
    dateController.text = getDate(widget.passValue[widget.passIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Colors.grey[50]),
      child: Padding(
        padding: const EdgeInsets.only(left: 24.0, top: 14, right: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            kHeight10,
            const Text(
              'Add a record',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            kHeight10,
            CustmPopupTxtField(
              controller: weightController,
            ),
            kHeight20,
            CustomDateField(
              dateController: dateController,
            ),
            kHeight20,
            Row(
              children: [
                Expanded(
                  child: CustomPopButton(
                      color: kwhite,
                      text: "cancel",
                      onTap: () {
                        Navigator.pop(context);
                      },
                      txtColor: primaryColor),
                ),
                kWidth8,
                Expanded(
                  child: Consumer(
                    builder: (context, ref, child) => CustomPopButton(
                      color: primaryColor,
                      text: "save",
                      onTap: () {
                        DatabaseService(
                                uid: FirebaseAuth.instance.currentUser!.uid)
                            .deleteWeight(widget.passValue[widget.passIndex]);
                        DatabaseService(
                                uid: FirebaseAuth.instance.currentUser!.uid)
                            .updatWeight(double.parse(weightController.text),
                                ref.read(dateProvider));

//

                        Navigator.pop(context);
                        showSnackBar(context, "weight updated successfully!");
                      },
                      txtColor: kwhite,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

void showUpdateWeightForm(BuildContext context, weight, index) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    isDismissible: false,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: SizedBox(
            height: MediaQuery.of(context).size.height / 2.4,
            width: double.infinity,
            child: ShowUpdateSheet(weight, index)),
      );
    },
  );
}
