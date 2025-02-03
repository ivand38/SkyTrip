import 'package:flutter/material.dart';
import 'package:travel_app/shared/theme.dart';

class TextFormWidget extends StatelessWidget {
  final String title;
  final String hintText;
  final TextEditingController controller;
  TextFormWidget(
      {super.key,
      required this.title,
      required this.hintText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: primaryTextStyle.copyWith(
            fontSize: 14,
            fontWeight: medium,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Field harus diisi';
            }
            return null;
          },
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: secondaryTextStyle.copyWith(
              fontSize: 14,
              fontWeight: regular,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: strokeColor),
              borderRadius: BorderRadius.circular(17),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
              borderRadius: BorderRadius.circular(17),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(17),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
              borderRadius: BorderRadius.circular(17),
            ),
          ),
        ),
      ],
    );
  }
}
