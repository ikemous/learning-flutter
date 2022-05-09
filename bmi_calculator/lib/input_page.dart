import 'package:flutter/material.dart';

const Color defaultCardBackground = Color(0xFF1D1E33);

class InputPage extends StatefulWidget {
  const InputPage({Key? key}) : super(key: key);

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("BMI Calculator"),
        ),
        body: Column(
          children: [
            Expanded(
                child: Row(
              children: const [
                Expanded(
                  child: AppCard(
                    cardColor: defaultCardBackground,
                  ),
                ),
                Expanded(
                    child: AppCard(
                  cardColor: defaultCardBackground,
                )),
              ],
            )),
            const Expanded(
                child: AppCard(
              cardColor: defaultCardBackground,
            )),
            Expanded(
                child: Row(
              children: const [
                Expanded(
                    child: AppCard(
                  cardColor: defaultCardBackground,
                )),
                Expanded(
                    child: AppCard(
                  cardColor: defaultCardBackground,
                )),
              ],
            )),
          ],
        ));
  }
}

class AppCard extends StatelessWidget {
  const AppCard({Key? key, required this.cardColor}) : super(key: key);

  final Color cardColor;
  // cardColor: Color(0xFF1D1E33),

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
