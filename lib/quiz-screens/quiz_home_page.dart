import 'package:demo_application/screens/quiz/components/body.dart';
import 'package:flutter/material.dart';
import 'package:demo_application/controllers/question_controller.dart';
import 'package:get/get.dart';


class QuizHomePage extends StatefulWidget {
  QuizHomePage({this.title});

  final String title;

  @override
  _QuizHomePageState createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Fluttter show the back button automatically
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
        ],
      ),
      body: Body(),
    );
  }
}
