import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app_final/business_logic/events/quiz_events.dart';
import 'package:quiz_app_final/business_logic/states/quiz_states.dart';
import 'package:quiz_app_final/data/models/category.dart';

/// BLoC
class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final Category _category;
  int _score = 0;
  int _index = 0;

  QuizBloc(this._category) : super(QuizInitialState()) {
    on<StartQuizEvent>(_onStartQuiz);
    on<AnswerQuestionEvent>(_onAnswerQuestion);
    on<NextQuestionEvent>(_onNextQuestion);
    on<RestartQuizEvent>(_onRestartQuiz);
  }

  void _onStartQuiz(StartQuizEvent event, Emitter<QuizState> emit) {
    _score = 0;
    _index = 0;

    emit(QuizInProgressState(
      currentQuestion: _category.questions[_index],
      score: _score,
      questionIndex: _index,
      totalQuestions: _category.questions.length,
    ));
  }

  void _onAnswerQuestion(AnswerQuestionEvent event, Emitter<QuizState> emit) {
    final isCorrect = event.answer == _category.questions[_index].isCorrect;

    if (isCorrect) _score++;

    // Emit feedback state
    emit(AnswerFeedbackState(isCorrect: isCorrect));
  }

  void _onNextQuestion(NextQuestionEvent event, Emitter<QuizState> emit) {
    if (_index < _category.questions.length - 1) {
      _index++;
      emit(QuizInProgressState(
        currentQuestion: _category.questions[_index],
        score: _score,
        questionIndex: _index,
        totalQuestions: _category.questions.length,
      ));
    } else {
      emit(QuizFinishedState(
        score: _score,
        totalQuestions: _category.questions.length,
      ));
    }
  }

  void _onRestartQuiz(RestartQuizEvent event, Emitter<QuizState> emit) {
    _score = 0;
    _index = 0;
    emit(QuizInProgressState(
      currentQuestion: _category.questions[_index],
      score: _score,
      questionIndex: _index,
      totalQuestions: _category.questions.length,
    ));
  }
}
