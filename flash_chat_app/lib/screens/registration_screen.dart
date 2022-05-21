import 'package:flash_chat_app/components/rounded_button.dart';
import 'package:flash_chat_app/constants.dart';
import 'package:flash_chat_app/screens/chat_screen.dart';
import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static const String id = 'registration';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  bool isSpinning = false;
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isSpinning,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                Container(
                  constraints: BoxConstraints(maxWidth: 450.0),
                  child: Column(
                    children: [
                      TextField(
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          email = value;
                          //Do something with the user input.
                        },
                        decoration: kFieldDecoration.copyWith(
                            hintText: "Enter Your Email."),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                        obscureText: true,
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          password = value;
                          //Do something with the user input.
                        },
                        decoration: kFieldDecoration.copyWith(
                            hintText: "Enter Your Password."),
                      ),
                      const SizedBox(
                        height: 24.0,
                      ),
                      RoundedButton(
                        onPressed: () async {
                          setState(() {
                            isSpinning = true;
                          });
                          try {
                            final userCred =
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);
                            if (userCred.user != null) {
                              setState(() {
                                isSpinning = false;
                              });
                              Navigator.pushNamed(context, ChatScreen.id);
                            }
                          } catch (e) {
                            setState(() {
                              isSpinning = false;
                            });
                            print(e);
                          }
                        },
                        buttonText: 'Register',
                        buttonColor: Colors.blueAccent,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, LoginScreen.id);
                          },
                          child: const Text("Already Registered. Log In Here"))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
