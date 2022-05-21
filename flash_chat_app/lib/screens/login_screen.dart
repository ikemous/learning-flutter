import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_app/components/rounded_button.dart';
import 'package:flash_chat_app/constants.dart';
import 'package:flash_chat_app/utilities/auth_services.dart';
import 'package:flash_chat_app/utilities/exceptions.dart';
import 'package:flash_chat_app/screens/chat_screen.dart';
import 'package:flash_chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String id = 'login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseServices authService = FirebaseServices();
  bool isLoggingIn = false;
  bool isValid = true;
  String errorMessage = "";
  String email = "";
  String password = "";

  void handleLogIn() async {
    setState(() {
      isLoggingIn = true;
    });
    try {
      final User? user =
          await authService.logIn(email: email, password: password);
      if (user != null) {
        setState(() {
          email = "";
          password = "";
          isValid = true;
          isLoggingIn = false;
        });
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, ChatScreen.id);
      }
    } on InvalidLoginException catch (_) {
      setState(() {
        errorMessage = "Email/Password Invalid";
        isValid = false;
        isLoggingIn = false;
      });
    } catch (_) {
      setState(() {
        isLoggingIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                constraints: const BoxConstraints(maxWidth: 450.0),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      textAlign: TextAlign.center,
                      enabled: !isLoggingIn,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: kFieldDecoration.copyWith(
                        hintText: "Enter Your Email.",
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
                    TextField(
                      obscureText: true,
                      textAlign: TextAlign.center,
                      enabled: !isLoggingIn,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kFieldDecoration.copyWith(
                        hintText: "Enter Your Password.",
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
                      buttonText: "Log In",
                      buttonColor: Colors.lightBlueAccent,
                      onPressed: handleLogIn,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          RegistrationScreen.id,
                        );
                      },
                      child: const Text("Register For Account Here"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
