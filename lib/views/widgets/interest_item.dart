import 'package:flutter/material.dart';
import 'package:travel_app/shared/theme.dart';

class InterestItem extends StatelessWidget {
  final String title;
  InterestItem({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Wrap(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/fi_check_circle.png',
              width: 16,
              height: 16,
            ),
            const SizedBox(
              width: 6,
            ),
            Expanded(
              child: Text(
                title,
                style: primaryTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: regular,
                ),
                softWrap: true,
              ),
            ),
          ],
        )
      ],
    ));
  }
}
