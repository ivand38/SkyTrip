import 'package:flutter/material.dart';
import 'package:travel_app/cubit/transaction_cubit.dart';
import 'package:travel_app/shared/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travel_app/views/widgets/transaction_card.dart';

class TransactionListScreen extends StatefulWidget {
  const TransactionListScreen({super.key});

  @override
  State<TransactionListScreen> createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  @override
  void initState() {
    context.read<TransactionCubit>().fetchTransaction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: bgColor,
            body: BlocBuilder<TransactionCubit, TransactionState>(
              builder: (context, state) {
                if (state is TransactionLoading) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: primaryColor,
                  ));
                } else if (state is TransactionSuccess) {
                  if (state.transactions.length == 0) {
                    return Center(
                        child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/transaction_not_found.png',
                              width: 200),
                          const SizedBox(height: 60),
                          Text(
                            'Belum Ada Transaksi',
                            style: primaryTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Kamu belum pernah melakukan Transaksi. Mulai transaksi sekarang dan nikmati kemudahannya!',
                            style: secondaryTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: regular,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ));
                  } else {
                    return SingleChildScrollView(
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Transaction List',
                                style: primaryTextStyle.copyWith(
                                  fontSize: 20,
                                  fontWeight: semiBold,
                                )),
                            const SizedBox(height: 20),
                            ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.transactions.length,
                                itemBuilder: (context, index) {
                                  return TransactionCard(
                                      state.transactions[index]);
                                }),
                          ],
                        ),
                      ),
                    );
                  }
                }
                return Container();
              },
            )));
  }
}
