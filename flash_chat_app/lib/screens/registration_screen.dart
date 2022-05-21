import 'package:flutter/material.dart';
import 'package:flash_chat_app/components/rounded_button.dart';
import 'package:flash_chat_app/constants.dart';
import 'package:flash_chat_app/screens/chat_screen.dart';
import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flash_chat_app/utilities/auth_services.dart';
import 'package:flash_chat_app/utilities/exceptions.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static const String id = 'registration';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final FirebaseServices firebaseServices = FirebaseServices();
  bool isRegistering = false;
  bool isEmailValid = true;
  bool isPasswordValid = true;
  String errorMessage = "";
  String email = "";
  String password = "";

  void registerUser() async {
    setState(() {
      isRegistering = true;
    });
    if (email == "" && password == "") {
      setState(() {
        isEmailValid = false;
        isPasswordValid = false;
        isRegistering = false;
        errorMessage = "Email and password required";
      });
      return;
    } else if (email == "") {
      setState(() {
        isRegistering = false;
        isEmailValid = false;
        errorMessage = "Email is required";
      });
      return;
    } else if (password == "") {
      setState(() {
        isRegistering = false;
        isPasswordValid = false;
        errorMessage = "Password is required";
      });
      return;
    }
    try {
      final user =
          await firebaseServices.register(email: email, password: password);
      if (user != null) {
        setState(() {
          isRegistering = false;
          isEmailValid = true;
          isPasswordValid = true;
        });
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(
          context,
          ChatScreen.id,
        );
      }
    } on InvalidEmailException catch (_) {
      setState(() {
        isRegistering = false;
        isEmailValid = false;
        isPasswordValid = true;
        errorMessage = "Invalid Email Address";
      });
    } on EmailAddressTakenException catch (_) {
      setState(() {
        isRegistering = false;
        isEmailValid = false;
        isPasswordValid = true;
        errorMessage = "Email Address Already Taken";
      });
    } on WeakPasswordExpection catch (_) {
      setState(() {
        isRegistering = false;
        isEmailValid = true;
        isPasswordValid = false;
        errorMessage = "Weak Password";
      });
    } on GenericAuthException catch (_) {
      setState(() {
        isRegistering = false;
        isEmailValid = false;
        isPasswordValid = false;
        errorMessage = "Something went wrong";
      });
    } catch (_) {
      setState(() {
        isRegistering = false;
        isEmailValid = false;
        isPasswordValid = false;
        errorMessage = "Something went wrong";
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
                      enabled: !isRegistering,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        email = value;
                      },
                      decoration: kFieldDecoration.copyWith(
                        hintText: "Enter Your Email.",
                        enabledBorder: OutlineInputBorder(
                          borderSide: isEmailValid
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
                      enabled: !isRegistering,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        password = value;
                      },
                      decoration: kFieldDecoration.copyWith(
                        hintText: "Enter Your Password.",
                        enabledBorder: OutlineInputBorder(
                          borderSide: isPasswordValid
                              ? const BorderSide(
                                  color: Colors.lightBlueAccent, width: 1.0)
                              : const BorderSide(color: Colors.red, width: 1.0),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(32.0)),
                        ),
                      ),
                    ),
                    isEmailValid && isPasswordValid
                        ? const SizedBox(
                            height: 24.0,
                          )
                        : Text(
                            errorMessage,
                            style: const TextStyle(
                              color: Colors.red,
                            ),
                          ),
                    RoundedButton(
                      onPressed: registerUser,
                      buttonText: isRegistering ? '...Registering' : 'Register',
                      buttonColor: Colors.blueAccent,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: const Text("Already Registered? Log In Here"),
                    )
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
