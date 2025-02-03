import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/models/transaction_model.dart';
import 'package:travel_app/shared/theme.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard(this.transaction, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
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
                          locale: 'id', symbol: 'IDR ', decimalDigits: 0)
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
                          locale: 'id', symbol: 'IDR ', decimalDigits: 0)
                      .format(transaction.grandTotal),
                  style: blueTextStyle.copyWith(
                      fontSize: 14, fontWeight: semiBold)),
            ],
          ),
        ],
      ),
    );
  }
}
