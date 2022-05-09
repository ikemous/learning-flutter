import 'dart:math';

class CalculatorBrain {
  final int height;
  final int weight;

  CalculatorBrain({required this.height, required this.weight});

  late double _bmi;

  String calculateBMI() {
    _bmi = weight / pow(height / 100, 2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult() {
    if (_bmi >= 25) {
      return "OverWeight";
    } else if (_bmi > 18.5) {
      return "Normal";
    }

    return "UnderWeight";
  }

  String getInterpretation() {
    if (_bmi >= 25) {
      return "You need to eat less probably";
    } else if (_bmi > 18.5) {
      return "You are doing great, keep eating the way you are";
    }
    return "You need to eat more...";
  }
}
