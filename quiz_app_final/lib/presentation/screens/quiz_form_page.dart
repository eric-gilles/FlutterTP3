import 'package:flutter/material.dart';
import 'package:quiz_app_final/presentation/widgets/quiz_form_widget.dart';

class QuizFormPage extends StatelessWidget {
  final Function(int) onNavigateToPage;

  const QuizFormPage({super.key, required this.onNavigateToPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[50],
      appBar: AppBar(
        title: const Text(
          'Ajouter un Quiz',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey[50],
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: QuizFormWidget(onNavigateToPage: onNavigateToPage),
      ),
    );
  }
}

