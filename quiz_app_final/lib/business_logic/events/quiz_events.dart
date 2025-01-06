import 'package:quiz_app_final/data/models/category.dart';

/// Events
abstract class QuizEvent {}

class StartQuizEvent extends QuizEvent {
  final Category category;

  StartQuizEvent(this.category);
}

class AnswerQuestionEvent extends QuizEvent {
  final bool answer;

  AnswerQuestionEvent(this.answer);
}

class NextQuestionEvent extends QuizEvent {}

class RestartQuizEvent extends QuizEvent {}