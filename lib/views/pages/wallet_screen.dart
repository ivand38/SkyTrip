import 'package:flutter/material.dart';
import 'package:travel_app/cubit/auth_cubit.dart';
import 'package:travel_app/models/user_model.dart';
import 'package:travel_app/shared/theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletScreen extends StatelessWidget {
  WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: bgColor,
            body: Container(
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
              child: BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  if (state is AuthSuccess) {
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(35)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nama',
                                          style: whiteTextStyle.copyWith(
                                            fontSize: 12,
                                            fontWeight: regular,
                                          ),
                                        ),
                                        Text(
                                          state.user.name,
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
                                Text(
                                    NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'IDR ',
                                            decimalDigits: 0)
                                        .format(state.user.balance),
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 20,
                                      fontWeight: semiBold,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            )));
  }
}
