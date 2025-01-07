import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_final/business_logic/blocs/quiz_bloc.dart';
import 'package:quiz_app_final/business_logic/events/quiz_events.dart';
import 'package:quiz_app_final/business_logic/states/quiz_states.dart';

class QuizPlayWidget extends StatelessWidget {
  final QuizInProgressState state;

  const QuizPlayWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.blueGrey[50],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Question ${state.questionIndex + 1} / ${state.totalQuestions}',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 180),
              ],
            ),
            if (state.currentQuestion.questionImage.isNotEmpty)
              Image.asset(
                state.currentQuestion.questionImage,
                height: 150,
              ),
            const SizedBox(height: 15),
            Text(
              state.currentQuestion.questionText,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<QuizBloc>().add(AnswerQuestionEvent(true));
                    context.read<QuizBloc>().add(NextQuestionEvent());
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text(
                    'Vrai',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<QuizBloc>().add(AnswerQuestionEvent(false));
                    context.read<QuizBloc>().add(NextQuestionEvent());
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text(
                    'Faux',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
