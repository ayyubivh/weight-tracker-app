import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_management_app/common/snackbar.dart';
import 'package:weight_management_app/core/colors/colors.dart';
import 'package:weight_management_app/core/consts.dart';
import 'package:weight_management_app/provider/providers.dart';
import 'package:weight_management_app/views/auth/service/database_service.dart';
import 'package:weight_management_app/views/home/widgets/custom_pop_btn.dart';
import 'package:weight_management_app/views/home/widgets/date_field.dart';
import 'custm_popxt_field.dart';

// DateTime dateTime = DateTime.now();
final TextEditingController weightController = TextEditingController();
final dateController = TextEditingController();

class ShowAddweightForm extends ConsumerWidget {
  const ShowAddweightForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  child: CustomPopButton(
                    color: primaryColor,
                    text: "save",
                    onTap: () {
                      DatabaseService(
                              uid: FirebaseAuth.instance.currentUser!.uid)
                          .addWeight(double.parse(weightController.text),
                              ref.read(dateProvider));
                      Navigator.pop(context);
                      showSnackBar(context, "weight added successfully!");
                    },
                    txtColor: kwhite,
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
