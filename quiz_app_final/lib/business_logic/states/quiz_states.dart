import 'package:quiz_app_final/data/models/question.dart';

/// States
abstract class QuizState {}

class QuizInitialState extends QuizState {}

class QuizInProgressState extends QuizState {
  final Question currentQuestion;
  final int score;
  final int questionIndex;
  final int totalQuestions;

  QuizInProgressState({
    required this.currentQuestion,
    required this.score,
    required this.questionIndex,
    required this.totalQuestions,
  });
}

class AnswerFeedbackState extends QuizState {
  final bool isCorrect;

  AnswerFeedbackState({required this.isCorrect});
}

class QuizFinishedState extends QuizState {
  final int score;
  final int totalQuestions;

  QuizFinishedState({
    required this.score,
    required this.totalQuestions,
  });
}