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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xylophone"),
      ),
    );
  }
}
