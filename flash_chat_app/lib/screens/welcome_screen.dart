import 'package:flash_chat_app/components/rounded_button.dart';
import 'package:flash_chat_app/screens/login_screen.dart';
import 'package:flash_chat_app/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'welcome';
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      backgroundColor: animation.value,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Container(
                      height: 60,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "Flash Chat",
                        textStyle: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                        speed: const Duration(milliseconds: 200),
                      ),
                    ],
                    isRepeatingAnimation: true,
                    repeatForever: true,
                  ),
                  // const Text("Flash Chat"),
                ],
              ),
              const SizedBox(
                height: 48.0,
              ),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 550.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RoundedButton(
                      buttonColor: Colors.lightBlueAccent,
                      onPressed: () {
                        //Go to login screen.
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      buttonText: 'Log In',
                    ),
                    RoundedButton(
                      onPressed: () {
                        //Go to registration screen.
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                      buttonText: 'Register',
                      buttonColor: Colors.blueAccent,
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
