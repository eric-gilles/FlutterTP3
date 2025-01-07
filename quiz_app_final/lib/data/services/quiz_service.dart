import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quiz_app_final/data/models/category.dart';
import 'package:quiz_app_final/data/models/question.dart';

class QuizService{
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  /// Méthode pour récupérer les catégories de quiz
  Stream<List<Category>> getCategories() {
    return _firebaseFireStore.collection('categories').snapshots().map((QuerySnapshot snapshot) {
      return snapshot.docs.map((doc) {
        return Category(
          id: doc.id,
          name: doc['name'],
          questions: [],
        );
      }).toList();
    });
  }

  /// Méthode pour récupérer la catégorie par ID
  Future<Category> getCategory(String categoryId) async {
    try {
      // Récupérer la catégorie
      DocumentSnapshot categorySnapshot = await _firebaseFireStore
          .collection('categories')
          .doc(categoryId)
          .get();

      if (!categorySnapshot.exists) {
        throw Exception('Catégorie non trouvée');
      }

      // Créer l'objet Category sans les questions
      Category category = Category(
        id: categorySnapshot.id,
        name: categorySnapshot['name'],
        questions: [],
      );

      return category;
    } catch (e) {
      throw Exception('Erreur lors de la récupération de la catégorie: $e');
    }
  }

  /// Méthode pour récupérer les questions d'une catégorie
  Future<List<Question>> getQuestionsForCategory(String categoryId) async {
    try {
      QuerySnapshot questionsSnapshot = await _firebaseFireStore
          .collection('categories')
          .doc(categoryId)
          .collection('questions')
          .get();

      // Transformer les documents en liste de questions
      List<Question> questions = questionsSnapshot.docs.map((doc) {
        return Question.withId(
          id: doc.id,
          questionText: doc['questionText'],
          isCorrect: doc['isCorrect'],
          questionImage: doc['questionImage'],
        );
      }).toList();

      return questions;
    } catch (e) {
      throw Exception('Erreur lors de la récupération des questions: $e');
    }
  }

  /// Méthode combinée pour récupérer la catégorie avec ses questions
  Future<Category> getCategoryWithQuestions(String categoryId) async {
    Category category = await getCategory(categoryId); // Récupérer la catégorie
    List<Question> questions = await getQuestionsForCategory(categoryId); // Récupérer les questions pour la catégorie
    category.questions = questions; // Assigner les questions à la catégorie

    return category;
  }

  /// Méthode d'ajout d'une catégorie et ses questions
  Future<void> addQuiz(Category category) async {
    try {
      // Ajouter la catégorie dans Firestore
      CollectionReference categories = _firebaseFireStore.collection('categories');
      DocumentReference categoryDocRef = await categories.add({
        'name': category.name,
      });

      // Ajouter les questions dans la sous-collection 'questions'
      CollectionReference questions = categoryDocRef.collection('questions');
      for (var question in category.questions) {
        await questions.add({
          'questionText': question.questionText,
          'isCorrect': question.isCorrect,
          'questionImage': question.questionImage,
        });
      }
    } catch (e) {
      rethrow;
    }
  }
}