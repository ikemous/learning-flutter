import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat_app/firebase_options.dart';
import 'package:flash_chat_app/utilities/exceptions.dart';

class FirebaseServices {
  Future<void> initializeApp() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<User?> logIn({
    required String email,
    required String password,
  }) async {
    UserCredential? currentUser;
    try {
      currentUser = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
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
