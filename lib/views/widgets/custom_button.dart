import 'package:flutter/material.dart';
import 'package:travel_app/shared/theme.dart';

class CustomButton extends StatefulWidget {
  final String title;
  CustomButton({super.key, required this.title});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(17),
      ),
      child: Center(
        child: Text(
          this.widget.title,
          style: whiteTextStyle.copyWith(
            fontSize: 16,
            fontWeight: semiBold,
          ),
        ),
      ),
    );
  }
}
