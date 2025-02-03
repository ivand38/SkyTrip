import 'package:equatable/equatable.dart';
import 'package:travel_app/models/destination_model.dart';
import 'package:travel_app/models/user_model.dart';

class TransactionModel extends Equatable {
  final String id;
  final String userId;
  final DestinationModel destination;
  final int amountOfTraveler;
  final String selectedSeats;
  final bool insurance;
  final bool refundable;
  final double vat;
  final int price;
  final int grandTotal;

  TransactionModel(
      {required this.destination,
      this.id = '',
      required this.userId,
      this.amountOfTraveler = 0,
      this.selectedSeats = '',
      this.insurance = false,
      this.refundable = false,
      this.vat = 0,
      this.price = 0,
      this.grandTotal = 0});

  factory TransactionModel.fromJson(String id, Map<String, dynamic> json) =>
      TransactionModel(
          destination: DestinationModel.fromJson(
              id, json['destination'] as Map<String, dynamic>),
          id: id,
          userId: json['userId'],
          amountOfTraveler: json['amountOfTraveler'],
          selectedSeats: json['selectedSeats'],
          insurance: json['insurance'],
          refundable: json['refundable'],
          vat: json['vat'].toDouble(),
          price: json['price'],
          grandTotal: json['grandTotal']);

  @override
  List<Object?> get props => [
        id,
        userId,
        destination,
        amountOfTraveler,
        selectedSeats,
        insurance,
        refundable,
        vat,
        price,
        grandTotal
      ];
}
