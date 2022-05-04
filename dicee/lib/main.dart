import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: const Text("Dicee"),
          backgroundColor: Colors.red,
        ),
        body: const DiceeApp(),
      ),
    ),
  );
}

class DiceeApp extends StatefulWidget {
  const DiceeApp({super.key});

  @override
  State<DiceeApp> createState() => _DiceeAppState();
}

class _DiceeAppState extends State<DiceeApp> {
  int leftDiceNumber = Random().nextInt(6) + 1;
  int rightDiceNumber = Random().nextInt(6) + 1;

  void rollDice() {
    setState(() {
      leftDiceNumber = Random().nextInt(6) + 1;
      rightDiceNumber = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: [
          Expanded(
            child: TextButton(
              onPressed: () => rollDice(),
              child: Image(
                image: AssetImage('images/dice$leftDiceNumber.png'),
              ),
            ),
          ),
          Expanded(
            child: TextButton(
              onPressed: () => rollDice(),
              child: Image(
                image: AssetImage('images/dice$rightDiceNumber.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class DiceeApp extends StatelessWidget {
//   const DiceeApp({Key? key}) : super(key: key);

//   final leftDiceNumber = 1;
//   final rightDiceNumber = 2;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Row(
//         children: [
//           Expanded(
//             child: TextButton(
//               onPressed: () {
//                 dev.log("Left Drice Clicked");
//               },
//               child: Image(
//                 image: AssetImage('images/dice$leftDiceNumber.png'),
//               ),
//             ),
//           ),
//           Expanded(
//             child: TextButton(
//               onPressed: () {
//                 dev.log("Right Dice Clicked");
//               },
//               child: Image(
//                 image: AssetImage('images/dice$rightDiceNumber.png'),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// Row(
//       children: const [
//         Expanded(
//           child: Image(
//             image: AssetImage('images/dice1.png'),
//           ),
//         ),
//         Expanded(
//           child: Image(
//             image: AssetImage('images/dice1.png'),
//           ),
//         ),
//       ],
//     );