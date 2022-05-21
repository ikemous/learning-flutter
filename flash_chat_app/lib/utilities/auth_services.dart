import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_app/utilities/exceptions.dart';

class AuthServices {
  final _auth = FirebaseAuth.instance;

  Future<User?> logIn({
    required String email,
    required String password,
  }) async {
    UserCredential? currentUser;
    try {
      currentUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (currentUser.user != null) {
        return currentUser.user;
      }
      throw UserNotLoggedInException();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "user-not-fround":
        case "wrong-password":
        case "invalid-email":
          throw InvalidLoginException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }
}
