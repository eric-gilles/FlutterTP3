import 'package:quiz_app_final/data/models/category.dart';
import 'package:quiz_app_final/data/models/question.dart';

class QuestionRepository {
  // Define categories and their associated questions
  final List<Category> _categories = [
    Category(
      id: "0",
      name: 'Culture générale',
      questions: [
        Question(questionText: 'Le requin est-il l’animal le plus dangereux pour l’homme ?', isCorrect: false, questionImage: 'assets/img/q1.png'),
        Question(questionText: 'Le Mont Fuji au Japon est un volcan ?', isCorrect: true, questionImage: 'assets/img/q2.png'),
        Question(questionText: 'One Piece est-il le meilleur manga ?', isCorrect: true, questionImage: 'assets/img/q3.png'),
        Question(questionText: 'Le panda roux est-il un proche parent du panda géant ?', isCorrect: false, questionImage: 'assets/img/q4.png'),
          Question(questionText: 'L’échelle de Scoville est-elle utilisée pour mesurer l’intensité des séismes ?', isCorrect: false, questionImage: 'assets/img/q5.png'),
      ],
    ),
    Category(
      id: "1",
      name: 'Espace',
      questions: [
        Question(questionText: 'Une Supernova est-elle une naissance d’étoile ?', isCorrect: false, questionImage: 'assets/img/q6.png'),
        Question(questionText: 'Le soleil représente 99,8% du poids total du Système solaire ?', isCorrect: true, questionImage: 'assets/img/q7.png'),
        Question(questionText: 'Les trous noirs peuvent-ils exister sans avoir de masse ?', isCorrect: false, questionImage: 'assets/img/q8.png'),
        Question(questionText: 'Les comètes sont-elles principalement constituées de poussières et de gaz ?', isCorrect: true, questionImage: 'assets/img/q9.png'),
        Question(questionText: 'Une année martienne dure-t-elle 485 jours terrestres ?', isCorrect: false, questionImage: 'assets/img/q10.png'),
      ],
    ),
    Category(
      id: "2",
      name: 'Géographie',
      questions: [
        Question(questionText: 'Paris est la capitale de la France ?', isCorrect: true, questionImage: 'assets/img/q11.png'),
        Question(questionText: 'Le Sahara fait-il plus de 10 millions de km² ?', isCorrect: false, questionImage: 'assets/img/q12.png'),
        Question(questionText: 'La route 66 permettait-elle de relier la côte est à la côte ouest des États-Unis ?', isCorrect: false, questionImage: 'assets/img/q13.png'),
        Question(questionText: 'Ce drapeau est celui du Qatar ?', isCorrect: true, questionImage: 'assets/img/q14.png'),
        Question(questionText: 'Melbourne est la capitale de l’Australie ?', isCorrect: false, questionImage: 'assets/img/q15.png'),
      ],
    ),
  ];

  Category? getCategory(String id) {
    for (var category in _categories) {
      if (category.id == id) {
        return category;
      }
    }
    return null;
  }

  List<String> get categoryNames => _categories.map((category) => category.name).toList();
}
