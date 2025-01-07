import 'package:flutter/material.dart';
import 'package:quiz_app_final/data/models/category.dart';
import 'package:quiz_app_final/data/models/question.dart';
import 'package:quiz_app_final/data/services/quiz_service.dart';

class QuizFormWidget extends StatefulWidget {
  final Function(int) onNavigateToPage;

  const QuizFormWidget({super.key, required this.onNavigateToPage});

  @override
  _QuizFormWidgetState createState() => _QuizFormWidgetState();
}

class _QuizFormWidgetState extends State<QuizFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _categoryNameController = TextEditingController();
  final List<Question> _questions = [];
  final _questionTextController = TextEditingController();
  final _imageController = TextEditingController();
  bool _isCorrect = true;

  /// Méthode pour ajouter une question
  void _addQuestion() {
    if (_questionTextController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez ne pas saisir une question vide')),
      );
      return;
    }

    setState(() {
      _questions.add(
        Question(
          questionText: _questionTextController.text,
          isCorrect: _isCorrect,
          questionImage: _imageController.text,
        ),
      );
      _questionTextController.clear();
      _imageController.clear();
    });
  }

  /// Méthode pour soumettre le formulaire
  void _submitForm() async {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate() && _questions.isNotEmpty) {
      final newCategory = Category(
        id: '',
        name: _categoryNameController.text,
        questions: _questions,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Quiz ajouté: ${newCategory.name}')),
      );

      QuizService quizService = QuizService();

      try {
        await quizService.addQuiz(newCategory);
        widget.onNavigateToPage(1);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Erreur lors de l\'ajout du quiz')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Veuillez avoir au moins une question pour le Quiz')),
      );
    }
  }

  /// Méthode pour supprimer une question du quiz
  void _deleteQuestion(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Supprimer la question'),
          content: const Text('Êtes-vous sûr de vouloir supprimer cette question ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _questions.removeAt(index);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Question supprimée')),
                );
              },
              child: const Text(
                'Supprimer',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: _categoryNameController,
              decoration: InputDecoration(
                labelText: 'Nom du Quiz',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              style: const TextStyle(fontSize: 16),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Veuillez saisir un nom de Quiz';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            Text(
              'Ajouter une question :',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _questionTextController,
              decoration: InputDecoration(
                labelText: 'Texte de la question',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text('Correct:', style: TextStyle(fontSize: 16)),
                Radio<bool>(
                  value: true,
                  groupValue: _isCorrect,
                  onChanged: (value) {
                    setState(() {
                      _isCorrect = value!;
                    });
                  },
                  activeColor: Colors.blueGrey[700],
                ),
                const Text('Vrai'),
                Radio<bool>(
                  value: false,
                  groupValue: _isCorrect,
                  onChanged: (value) {
                    setState(() {
                      _isCorrect = value!;
                    });
                  },
                  activeColor: Colors.blueGrey[700],
                ),
                const Text('Faux'),
              ],
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _imageController,
              decoration: InputDecoration(
                labelText: 'URL de l\'image (optionnel)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addQuestion,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                backgroundColor: Colors.blueAccent[700],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Ajouter la question',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  backgroundColor: Colors.blueAccent[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Enregistrer le Quiz',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_questions.isNotEmpty)
              const Text(
                'Questions Ajoutées :',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            const SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _questions.length,
              itemBuilder: (context, index) {
                final question = _questions[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      question.questionText,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    subtitle: Text(
                      'Correct: ${question.isCorrect ? 'Vrai' : 'Faux'}',
                      style: TextStyle(fontSize: 14, color: Colors.blueGrey[700]),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteQuestion(index),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
