import 'package:flash_chat_app/constants.dart';
import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flash_chat_app/utilities/exceptions.dart';
import 'package:flash_chat_app/utilities/firebase_services.dart';
import 'package:flutter/material.dart';

import '../components/rounded_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);
  static String id = 'forgot-password';

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  FirebaseServices firebaseService = FirebaseServices();
  bool isResetingPassword = false;
  bool isValid = true;
  String errorMessage = "";
  String email = "";

  void handleResetPassword() async {
    setState(() {
      isResetingPassword = true;
    });

    try {
      await firebaseService.resetPassword(email: email);
      setState(() {
        isResetingPassword = false;
      });
    } on InvalidEmailException catch (_) {
      setState(() {
        isResetingPassword = false;
        isValid = false;
        errorMessage = "Invalid Email or User Doesn't Exist";
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Hero(
                tag: 'logo',
                child: SizedBox(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
            ),
            const SizedBox(
              height: 48.0,
            ),
            Container(
              constraints: const BoxConstraints(
                maxWidth: 450.0,
              ),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    enabled: !isResetingPassword,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kFieldDecoration.copyWith(
                      hintText: "Email Address",
                      enabledBorder: OutlineInputBorder(
                        borderSide: isValid
                            ? const BorderSide(
                                color: Colors.lightBlueAccent, width: 1.0)
                            : const BorderSide(color: Colors.red, width: 1.0),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(32.0)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  !isValid
                      ? Text(
                          textAlign: TextAlign.left,
                          errorMessage,
                          style: const TextStyle(
                            color: Colors.red,
                          ),
                        )
                      : const SizedBox(
                          height: 24.0,
                        ),
                  RoundedButton(
                    buttonText: "Send Reset Email",
                    buttonColor: Colors.lightBlueAccent,
                    onPressed: handleResetPassword,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        LoginScreen.id,
                      );
                    },
                    child: const Text("Register For Account Here"),
                  ),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
