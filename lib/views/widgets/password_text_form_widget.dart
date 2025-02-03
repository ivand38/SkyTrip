import 'package:flutter/material.dart';
import 'package:travel_app/shared/theme.dart';

class PasswordTextFormWidget extends StatefulWidget {
  final TextEditingController controller;

  PasswordTextFormWidget({required this.controller});

  @override
  _PasswordTextFormWidgetState createState() => _PasswordTextFormWidgetState();
}

class _PasswordTextFormWidgetState extends State<PasswordTextFormWidget> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: primaryTextStyle.copyWith(
            fontSize: 14,
            fontWeight: medium,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: widget.controller,
          obscureText: !_isPasswordVisible,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Field harus diisi';
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: 'Password',
            hintStyle: secondaryTextStyle.copyWith(
              fontSize: 14,
              fontWeight: regular,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              child: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: strokeColor,
              ),
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
