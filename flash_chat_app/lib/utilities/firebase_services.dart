import 'package:cloud_firestore/cloud_firestore.dart';
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

  Stream<QuerySnapshot<Map<String, dynamic>>> getSnapshotsByDate() {
    return FirebaseFirestore.instance
        .collection('messages')
        .orderBy('sent')
        .snapshots();
  }

  Future<void> addMessage(Map<String, dynamic> data) async {
    await FirebaseFirestore.instance.collection('messages').add(data);
  }

  User? getCurrentUser() => FirebaseAuth.instance.currentUser;

  Future<User?> register({
    required String email,
    required String password,
  }) async {
    UserCredential? userCredential;
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        return userCredential.user;
      }
      throw UserNotLoggedInException();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          throw EmailAddressTakenException();
        case "weak-password":
          throw WeakPasswordExpection();
        case "invalid-email":
          throw InvalidEmailException();
        default:
          throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
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

  Future<void> resetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          throw InvalidEmailException();
        default:
          throw GenericAuthException();
      }
    } catch (e) {
      throw GenericAuthException();
    }
  }
}
