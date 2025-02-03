import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:travel_app/models/user_model.dart';
import 'package:travel_app/services/auth_service.dart';
import 'package:travel_app/services/user_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signUp(
      {required String email,
      required String password,
      required String name,
      required String hobby}) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService()
          .signUp(email: email, password: password, name: name, hobby: hobby);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signIn({required String email, required String password}) async {
    try {
      emit(AuthLoading());
      UserModel user =
          await AuthService().signIn(email: email, password: password);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await AuthService().signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void getCurrentUser(String id) async {
    try {
      UserModel user = await UserService().getUser(id);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void updateUser(UserModel user) async {
    try {
      emit(AuthLoading());
      await UserService().updateUser(user);
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void updateUserBalance(UserModel user, int newBalance) async {
    try {
      emit(AuthLoading());
      await UserService().updateUserBalance(user, newBalance);
      final updatedUser = await UserService().getUser(user.id);
      emit(AuthSuccess(updatedUser));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
