import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weight_management_app/core/colors/colors.dart';
import '../../../provider/providers.dart';

// DateTime dateTime = DateTime.now();

class CustomDateField extends StatelessWidget {
  const CustomDateField({super.key, required this.dateController});
  final TextEditingController dateController;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (BuildContext context, WidgetRef ref, child) {
      ref.watch(dateProvider.notifier);
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
        child: TextField(
          controller: dateController,
          style: TextStyle(color: primaryColor),
          decoration: InputDecoration(
            prefixIcon: const Icon(
              Icons.calendar_month,
              color: Colors.grey,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none),
            filled: true,
            contentPadding: const EdgeInsets.all(15),
            fillColor: Colors.grey[300],
            hintText: 'Date',
            hintStyle: const TextStyle(
                letterSpacing: 1,
                color: Colors.grey,
                fontSize: 16.0,
                fontWeight: FontWeight.w700),
          ),
          readOnly: true,
          onTap: () async {
            final date = await pickDate(context);

            if (date == null) return;
            final newDateTime = DateTime(
              date.year,
              date.month,
              date.day,
            );
            ref.read(dateProvider.notifier).state = newDateTime;
            dateController.text = DateFormat("y MMM d ").format(newDateTime);
          },
        ),
      );
    });
  }
}

Future<DateTime?> pickDate(context) => showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now());
