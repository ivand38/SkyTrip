import 'package:flutter/material.dart';
import 'package:travel_app/cubit/seat_cubit.dart';
import 'package:travel_app/models/destination_model.dart';
import 'package:travel_app/models/transaction_model.dart';
import 'package:travel_app/shared/theme.dart';
import 'package:travel_app/views/widgets/custom_button.dart';
import 'package:travel_app/views/widgets/plane_seat_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChooseSeatScreen extends StatelessWidget {
  final DestinationModel destination;

  ChooseSeatScreen({super.key, required this.destination});

  int i = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
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
          margin: EdgeInsets.symmetric(horizontal: 24, vertical: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Choose Your\nSeat',
                  style: primaryTextStyle.copyWith(
                    fontSize: 24,
                    fontWeight: semiBold,
                  )),
              const SizedBox(height: 30),
              Row(
                children: [
                  Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      color: strokeColor,
                      border: Border.all(color: primaryColor, width: 1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text('Available',
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      )),
                  const SizedBox(width: 10),
                  Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text('Selected',
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      )),
                  const SizedBox(width: 10),
                  Container(
                    height: 16,
                    width: 16,
                    decoration: BoxDecoration(
                      color: strokeColor,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text('Unavailable',
                      style: primaryTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: regular,
                      )),
                ],
              ),
              const SizedBox(height: 30),
              BlocBuilder<SeatCubit, List<String>>(
                builder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 30),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                                child: Center(
                              child: Text(
                                'A',
                                style: secondaryTextStyle.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            )),
                            Expanded(
                                child: Center(
                              child: Text(
                                'B',
                                style: secondaryTextStyle.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            )),
                            Expanded(
                                child: Center(
                              child: Text(
                                ' ',
                                style: secondaryTextStyle.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            )),
                            Expanded(
                                child: Center(
                              child: Text(
                                'C',
                                style: secondaryTextStyle.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            )),
                            Expanded(
                                child: Center(
                              child: Text(
                                'D',
                                style: secondaryTextStyle.copyWith(
                                  fontSize: 16,
                                ),
                              ),
                            ))
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              PlaneSeatWidget(
                                id: 'A1',
                                isAvailable: false,
                              ),
                              PlaneSeatWidget(
                                id: 'B1',
                                isAvailable: false,
                              ),
                              Container(
                                width: 48,
                                height: 48,
                                child: Center(
                                  child: Text(
                                    '1',
                                    style: secondaryTextStyle.copyWith(
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              PlaneSeatWidget(
                                id: 'C1',
                              ),
                              PlaneSeatWidget(
                                id: 'D1',
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              PlaneSeatWidget(
                                id: 'A2',
                              ),
                              PlaneSeatWidget(
                                id: 'B2',
                              ),
                              Container(
                                width: 48,
                                height: 48,
                                child: Center(
                                  child: Text(
                                    '2',
                                    style: secondaryTextStyle.copyWith(
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              PlaneSeatWidget(
                                id: 'C2',
                              ),
                              PlaneSeatWidget(
                                id: 'D2',
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              PlaneSeatWidget(
                                id: 'A3',
                              ),
                              PlaneSeatWidget(
                                id: 'B3',
                              ),
                              Container(
                                width: 48,
                                height: 48,
                                child: Center(
                                  child: Text(
                                    '3',
                                    style: secondaryTextStyle.copyWith(
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              PlaneSeatWidget(
                                id: 'C3',
                              ),
                              PlaneSeatWidget(
                                id: 'D3',
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              PlaneSeatWidget(
                                id: 'A4',
                              ),
                              PlaneSeatWidget(
                                id: 'B4',
                              ),
                              Container(
                                width: 48,
                                height: 48,
                                child: Center(
                                  child: Text(
                                    '4',
                                    style: secondaryTextStyle.copyWith(
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              PlaneSeatWidget(
                                id: 'C4',
                              ),
                              PlaneSeatWidget(
                                id: 'D4',
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              PlaneSeatWidget(
                                id: 'A5',
                              ),
                              PlaneSeatWidget(
                                id: 'B5',
                              ),
                              Container(
                                width: 48,
                                height: 48,
                                child: Center(
                                  child: Text(
                                    '5',
                                    style: secondaryTextStyle.copyWith(
                                        fontSize: 16),
                                  ),
                                ),
                              ),
                              PlaneSeatWidget(
                                id: 'C5',
                              ),
                              PlaneSeatWidget(
                                id: 'D5',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Your Seat',
                                  style: secondaryTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: medium,
                                  )),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  state.isEmpty ? 'None' : state.join(', '),
                                  style: primaryTextStyle.copyWith(
                                    fontSize: 16,
                                    fontWeight: semiBold,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total',
                                style: secondaryTextStyle.copyWith(
                                  fontSize: 14,
                                  fontWeight: medium,
                                )),
                            const SizedBox(width: 10),
                            Text(
                              NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'IDR ',
                                      decimalDigits: 0)
                                  .format(state.length * destination.price),
                              style: blueTextStyle.copyWith(
                                fontSize: 16,
                                fontWeight: semiBold,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 30),
              BlocBuilder<SeatCubit, List<String>>(
                builder: (context, state) {
                  return GestureDetector(
                      onTap: () {
                        if (state.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Tidak Ada Kursi Yang Dipilih'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        } else {
                          int price = destination.price * state.length;
                          User? user = FirebaseAuth.instance.currentUser;

                          Navigator.pushNamed(context, '/checkout',
                              arguments: TransactionModel(
                                userId: user!.uid,
                                destination: destination,
                                amountOfTraveler: state.length,
                                selectedSeats: state.join(', '),
                                insurance: true,
                                refundable: false,
                                price: price,
                                grandTotal: price + (price * 0.11).toInt(),
                              ));
                        }
                      },
                      child: CustomButton(title: 'Continue to Checkout'));
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
