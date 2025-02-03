import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/models/transaction_model.dart';

class TransactionService {
  CollectionReference _transactionReference =
      FirebaseFirestore.instance.collection('transactions');

  Future<void> setTransaction(TransactionModel transaction) async {
    try {
      await _transactionReference.add({
        'userId': transaction.userId,
        'destination': transaction.destination.toJson(),
        'amountOfTraveler': transaction.amountOfTraveler,
        'selectedSeats': transaction.selectedSeats,
        'insurance': transaction.insurance,
        'refundable': transaction.refundable,
        'vat': transaction.vat,
        'price': transaction.price,
        'grandTotal': transaction.grandTotal,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<List<TransactionModel>> fetchTransaction(String userId) async {
    try {
      QuerySnapshot result =
          await _transactionReference.where('userId', isEqualTo: userId).get();
      List<TransactionModel> transactions = result.docs.map((e) {
        return TransactionModel.fromJson(
            e.id, e.data() as Map<String, dynamic>);
      }).toList();
      return transactions;
    } catch (e) {
      throw e;
    }
  }
}
