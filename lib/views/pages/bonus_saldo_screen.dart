import 'package:flutter/material.dart';
import 'package:travel_app/models/user_model.dart';
import 'package:travel_app/shared/theme.dart';
import 'package:travel_app/views/widgets/custom_button.dart';

class BonusSaldoScreen extends StatefulWidget {
  final UserModel user;

  BonusSaldoScreen({super.key, required this.user});

  @override
  State<BonusSaldoScreen> createState() => _BonusSaldoScreenState();
}

class _BonusSaldoScreenState extends State<BonusSaldoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // INI BAGIAN BOX WALLET
              Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.5),
                        spreadRadius: 0,
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      )
                    ],
                    color: primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Nama',
                                style: whiteTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: regular,
                                ),
                              ),
                              Text(
                                widget.user.name,
                                style: whiteTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: semiBold,
                                ),
                              )
                            ],
                          ),
                          Image.asset(
                            'assets/wallet_logo.png',
                            width: 80,
                          )
                        ],
                      ),
                      const SizedBox(height: 40),
                      Text('Saldo',
                          style: whiteTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: regular,
                          )),
                      Text('Rp. 5.000.000',
                          style: whiteTextStyle.copyWith(
                            fontSize: 20,
                            fontWeight: semiBold,
                          )),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Text('Big Bonus 🎉',
                  style: blueTextStyle.copyWith(
                    fontSize: 28,
                    fontWeight: bold,
                  )),
              const SizedBox(height: 10),
              Text(
                  'We give you early credit so that\nyou can buy a flight ticket',
                  textAlign: TextAlign.center,
                  style: secondaryTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: regular,
                  )),
              const SizedBox(height: 50),
              GestureDetector(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/main', (route) => false);
                  },
                  child: CustomButton(title: 'Start Fly Now'))
            ],
          ),
        ),
      ),
    );
  }
}
