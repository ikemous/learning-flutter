import 'package:flutter/material.dart';
import 'package:story_app/story_brain.dart';

StoryBrain storyBrain = StoryBrain();

void main() {
  runApp(const StoryApp());
}

class StoryApp extends StatelessWidget {
  const StoryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Story Time",
      theme: ThemeData.dark(),
      home: const StoryTeller(),
    );
  }
}

class StoryTeller extends StatefulWidget {
  const StoryTeller({Key? key}) : super(key: key);

  @override
  State<StoryTeller> createState() => _StoryTellerState();
}

class _StoryTellerState extends State<StoryTeller> {
  String storyTitle = storyBrain.getStory();
  String choice1 = storyBrain.getChoice1();
  String choice2 = storyBrain.getChoice2();
  bool isVisible = storyBrain.buttonShouldBeVisible();

  void makeChoice(int choiceNumber) {
    storyBrain.nextStory(choiceNumber);
    setState(() {
      storyTitle = storyBrain.getStory();
      choice1 = storyBrain.getChoice1();
      choice2 = storyBrain.getChoice2();
      isVisible = storyBrain.buttonShouldBeVisible();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('images/background.png'),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 50.0,
          horizontal: 15.0,
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 12,
                child: Center(
                  child: Text(
                    storyTitle,
                    style: const TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () => makeChoice(1),
                  child: Text(
                    choice1,
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                flex: 2,
                child: Visibility(
                  visible: isVisible,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () => makeChoice(2),
                    child: Text(
                      choice2,
                      style: const TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
