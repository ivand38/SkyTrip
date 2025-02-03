import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:travel_app/models/user_model.dart';

class UserService {
  CollectionReference _userReference =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userReference.doc(user.id).set({
        'email': user.email,
        'name': user.name,
        'hobby': user.hobby,
        'profilePic': user.profilePic,
        'balance': user.balance,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> getUser(String id) async {
    try {
      DocumentSnapshot userSnapshot = await _userReference.doc(id).get();
      return UserModel(
        id: id,
        email: userSnapshot['email'],
        name: userSnapshot['name'],
        hobby: userSnapshot['hobby'],
        profilePic: userSnapshot['profilePic'],
        balance: userSnapshot['balance'],
      );
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await _userReference.doc(user.id).update({
        'name': user.name,
        'hobby': user.hobby,
        'profilePic': user.profilePic,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateUserBalance(UserModel user, int newBalance) async {
    try {
      await _userReference.doc(user.id).update({
        'balance': newBalance,
      });
    } catch (e) {
      throw e;
    }
  }
}
