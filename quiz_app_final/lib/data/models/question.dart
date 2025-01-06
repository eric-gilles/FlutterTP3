class Question {
  String? id;
  String questionText;
  bool isCorrect;
  String questionImage;

  Question({required this.questionText, required this.isCorrect, required this.questionImage});
  Question.withId({required this.id, required this.questionText, required this.isCorrect, required this.questionImage});
}