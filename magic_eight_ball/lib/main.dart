import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: "Magic Eight Ball",
      home: MagicEightBallApp(),
    ),
  );
}

class MagicEightBallApp extends StatefulWidget {
  const MagicEightBallApp({super.key});

  @override
  State<MagicEightBallApp> createState() => _MagicEightBallAppState();
}

class _MagicEightBallAppState extends State<MagicEightBallApp> {
  int ballAnswer = Random().nextInt(5) + 1;

  void shakeBall() {
    setState(() {
      ballAnswer = Random().nextInt(5) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[500],
      appBar: AppBar(
        title: const Text("Ask Me Anything"),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 40.0),
                child: TextButton(
                  onPressed: shakeBall,
                  child: Image(
                    image: AssetImage('images/ball$ballAnswer.png'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
