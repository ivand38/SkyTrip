import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/cubit/auth_cubit.dart';
import 'package:travel_app/cubit/transaction_cubit.dart';
import 'package:travel_app/models/transaction_model.dart';
import 'package:travel_app/shared/theme.dart';
import 'package:travel_app/views/widgets/custom_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

class CheckoutScreen extends StatelessWidget {
  final TransactionModel transaction;

  CheckoutScreen({
    super.key,
    required this.transaction,
  });

  void _checkout(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final state = authCubit.state;

    if (state is AuthSuccess) {
      final user = state.user;
      final newBalance = user.balance - transaction.grandTotal;

      if (newBalance >= 0) {
        authCubit.updateUserBalance(user, newBalance);
        context.read<TransactionCubit>().createTransaction(transaction);
        Navigator.pushNamedAndRemoveUntil(
            context, '/success', (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Order Sukses'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Saldo Tidak Cukup'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: blackColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: bgColor,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Checkout Pesanan Kamu',
                style: primaryTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: CachedNetworkImage(
                            imageUrl: transaction.destination.imageUrl,
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction.destination.name,
                                style: primaryTextStyle.copyWith(
                                  fontSize: 16,
                                  fontWeight: semiBold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                transaction.destination.country,
                                style: secondaryTextStyle.copyWith(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'assets/star.png',
                              width: 20,
                              height: 20,
                            ),
                            const SizedBox(width: 5),
                            Container(
                              padding: EdgeInsets.only(top: 4),
                              child: Text(
                                transaction.destination.rating.toString(),
                                style: primaryTextStyle.copyWith(
                                    fontSize: 14, fontWeight: semiBold),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text('Booking Details',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        )),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/fi_check_circle.png',
                                width: 20, height: 20),
                            const SizedBox(width: 6),
                            Text('Traveler',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 14,
                                )),
                          ],
                        ),
                        Text('${transaction.amountOfTraveler} Person',
                            style: primaryTextStyle.copyWith(
                                fontSize: 14, fontWeight: semiBold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/fi_check_circle.png',
                                width: 20, height: 20),
                            const SizedBox(width: 6),
                            Text('Seat',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 14,
                                )),
                          ],
                        ),
                        Expanded(
                          child: Text(transaction.selectedSeats,
                              textAlign: TextAlign.end,
                              style: primaryTextStyle.copyWith(
                                  fontSize: 14, fontWeight: semiBold)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/fi_check_circle.png',
                                width: 20, height: 20),
                            const SizedBox(width: 6),
                            Text('Insurance',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 14,
                                )),
                          ],
                        ),
                        Text(transaction.insurance ? 'Include' : 'Exclude',
                            style: transaction.insurance
                                ? greenTextStyle.copyWith(
                                    fontSize: 14, fontWeight: semiBold)
                                : redTextStyle.copyWith(
                                    fontSize: 14, fontWeight: semiBold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/fi_check_circle.png',
                                width: 20, height: 20),
                            const SizedBox(width: 6),
                            Text('Refundable',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 14,
                                )),
                          ],
                        ),
                        Text(transaction.refundable ? 'Yes' : 'No',
                            style: transaction.refundable
                                ? greenTextStyle.copyWith(
                                    fontSize: 14, fontWeight: semiBold)
                                : redTextStyle.copyWith(
                                    fontSize: 14, fontWeight: semiBold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/fi_check_circle.png',
                                width: 20, height: 20),
                            const SizedBox(width: 6),
                            Text('VAT',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 14,
                                )),
                          ],
                        ),
                        Text('11%',
                            style: primaryTextStyle.copyWith(
                                fontSize: 14, fontWeight: semiBold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/fi_check_circle.png',
                                width: 20, height: 20),
                            const SizedBox(width: 6),
                            Text('Price',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 14,
                                )),
                          ],
                        ),
                        Text(
                            NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'IDR ',
                                    decimalDigits: 0)
                                .format(transaction.price),
                            style: primaryTextStyle.copyWith(
                                fontSize: 14, fontWeight: semiBold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/fi_check_circle.png',
                                width: 20, height: 20),
                            const SizedBox(width: 6),
                            Text('Total Price',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 14,
                                )),
                          ],
                        ),
                        Text(
                            NumberFormat.currency(
                                    locale: 'id',
                                    symbol: 'IDR ',
                                    decimalDigits: 0)
                                .format(transaction.grandTotal),
                            style: blueTextStyle.copyWith(
                                fontSize: 14, fontWeight: semiBold)),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Payment Details',
                        style: primaryTextStyle.copyWith(
                          fontSize: 16,
                          fontWeight: semiBold,
                        )),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 120,
                          height: 90,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(18))),
                          child: Image.asset('assets/wallet_logo.png'),
                        ),
                        const SizedBox(width: 16),
                        BlocBuilder<AuthCubit, AuthState>(
                          builder: (context, state) {
                            if (state is AuthSuccess) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                      NumberFormat.currency(
                                              locale: 'id',
                                              symbol: 'IDR ',
                                              decimalDigits: 0)
                                          .format(state.user.balance),
                                      style: primaryTextStyle.copyWith(
                                          fontSize: 18, fontWeight: semiBold)),
                                  const SizedBox(height: 5),
                                  Text('Wallet Balance',
                                      style: secondaryTextStyle.copyWith(
                                        fontSize: 14,
                                      )),
                                ],
                              );
                            }
                            return SizedBox();
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              BlocConsumer<TransactionCubit, TransactionState>(
                listener: (context, state) {
                  if (state is TransactionSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/success', (route) => false);
                  } else if (state is TransactionFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        elevation: 4.0,
                        behavior: SnackBarBehavior.floating,
                        content: Text(state.error),
                        backgroundColor: redColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is TransactionLoading) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                      ),
                    );
                  }

                  return GestureDetector(
                      onTap: () {
                        _checkout(context);
                      },
                      child: CustomButton(title: 'Pay Now'));
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
