import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/models/user_model.dart';
import 'package:travel_app/services/user_service.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
    required String hobby,
  }) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      UserModel user = UserModel(
          id: userCredential.user!.uid,
          email: email,
          name: name,
          hobby: hobby,
          profilePic:
              'https://firebasestorage.googleapis.com/v0/b/airplane-mobile-app.firebasestorage.app/o/profile%2FFrame%2054.png?alt=media&token=752ac8c3-4e02-42cb-aba7-1cd7f1144fc3',
          balance: 5000000);

      await UserService().setUser(user);
      return user;
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      UserModel user = await UserService().getUser(userCredential.user!.uid);
      return user;
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    }
  }
}
