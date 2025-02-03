import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/cubit/page_cubit.dart';
import 'package:travel_app/shared/theme.dart';
import 'package:travel_app/views/widgets/custom_button.dart';

class SuccessCheckoutScreen extends StatelessWidget {
  const SuccessCheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Container(
          margin: const EdgeInsets.all(40),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/success.png', width: 300),
              const SizedBox(height: 80),
              Text(
                'Well Booked',
                style: blueTextStyle.copyWith(fontSize: 28, fontWeight: bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Are you ready to explore the new\nworld of experiences?',
                textAlign: TextAlign.center,
                style: secondaryTextStyle.copyWith(fontSize: 14),
              ),
              const SizedBox(height: 50),
              GestureDetector(
                  onTap: () {
                    context.read<PageCubit>().setPage(1);
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/main', (route) => false);
                  },
                  child: CustomButton(title: 'My Bookings'))
            ],
          ),
        ),
      ),
    );
  }
}
