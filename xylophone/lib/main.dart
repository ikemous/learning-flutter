import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      title: "Xylophone App",
      home: XylophoneApp(),
    ),
  );
}

class XylophoneApp extends StatelessWidget {
  const XylophoneApp({Key? key}) : super(key: key);

  void playAudio(int audioNumber) {
    final player = AudioCache();
    player.play("assets_note$audioNumber.wav");
  }

  Expanded buildKey(
      {required Color buttonBackground, required int soundNumber}) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(backgroundColor: buttonBackground),
        child: Container(),
        onPressed: () => playAudio(soundNumber),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            buildKey(buttonBackground: Colors.red, soundNumber: 1),
            buildKey(buttonBackground: Colors.orange, soundNumber: 2),
            buildKey(buttonBackground: Colors.yellow, soundNumber: 3),
            buildKey(buttonBackground: Colors.lightGreen, soundNumber: 4),
            buildKey(buttonBackground: Colors.green, soundNumber: 5),
            buildKey(buttonBackground: Colors.lightBlue, soundNumber: 6),
            buildKey(buttonBackground: Colors.purple, soundNumber: 7),
          ],
        ),
      ),
    );
  }
}

// Expanded(
//               child: TextButton(
//                 style: TextButton.styleFrom(backgroundColor: Colors.red),
//                 child: Container(),
//                 onPressed: () => playAudio(1),
//               ),
//             ),
//             Expanded(
//               child: TextButton(
//                 style: TextButton.styleFrom(backgroundColor: Colors.orange),
//                 child: Container(),
//                 onPressed: () => playAudio(2),
//               ),
//             ),
//             Expanded(
//               child: TextButton(
//                 style: TextButton.styleFrom(backgroundColor: Colors.yellow),
//                 child: Container(),
//                 onPressed: () => playAudio(3),
//               ),
//             ),
//             Expanded(
//               child: TextButton(
//                 style: TextButton.styleFrom(backgroundColor: Colors.lightGreen),
//                 child: Container(),
//                 onPressed: () => playAudio(4),
//               ),
//             ),
//             Expanded(
//               child: TextButton(
//                 style: TextButton.styleFrom(backgroundColor: Colors.green),
//                 child: Container(),
//                 onPressed: () => playAudio(5),
//               ),
//             ),
//             Expanded(
//               child: TextButton(
//                 style: TextButton.styleFrom(backgroundColor: Colors.lightBlue),
//                 child: Container(),
//                 onPressed: () => playAudio(6),
//               ),
//             ),
//             Expanded(
//               child: TextButton(
//                 style: TextButton.styleFrom(backgroundColor: Colors.purple),
//                 child: Container(),
//                 onPressed: () => playAudio(7),
//               ),
//             ),
