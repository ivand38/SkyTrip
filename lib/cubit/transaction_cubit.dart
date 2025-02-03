import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';
import 'package:travel_app/models/transaction_model.dart';
import 'package:travel_app/services/transaction_service.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  void createTransaction(TransactionModel transaction) async {
    try {
      emit(TransactionLoading());
      await TransactionService().setTransaction(transaction);
      emit(TransactionSuccess([]));
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }

  void fetchTransaction() async {
    try {
      emit(TransactionLoading());
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        List<TransactionModel> transactions =
            await TransactionService().fetchTransaction(user!.uid);
        emit(TransactionSuccess(transactions));
      } else {
        emit(TransactionFailed('User not found'));
      }
    } catch (e) {
      emit(TransactionFailed(e.toString()));
    }
  }
}
