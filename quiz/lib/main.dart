import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:quiz/quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(const QuizApp());

class QuizApp extends StatelessWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quiz App",
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static Icon checkIcon = const Icon(
    Icons.check,
    color: Colors.green,
  );

  static Icon closeIcon = const Icon(
    Icons.close,
    color: Colors.red,
  );
  List<Icon> scoreKeeper = [checkIcon, closeIcon];

  void handleAnswer(bool userResponse) {
    if (quizBrain.isFinished()) {
      Alert(
        context: context,
        title: 'Finished!',
        desc: 'The quiz is completed!',
      ).show();
      quizBrain.reset();
      return setState(() {
        scoreKeeper = [];
      });
    }
    bool questionAnswer = quizBrain.getQuestionAnswer();
    Icon responseIcon = userResponse == questionAnswer ? checkIcon : closeIcon;

    quizBrain.nextQuestion();
    setState(() {
      scoreKeeper.add(responseIcon);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                style: const TextStyle(color: Colors.white, fontSize: 25.0),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Text(
                "True",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () => handleAnswer(true),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: const Text(
                "False",
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
              onPressed: () => handleAnswer(false),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}
