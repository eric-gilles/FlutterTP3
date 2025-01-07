import 'package:flutter/material.dart';
import 'package:quiz_app_final/data/models/category.dart';
import 'package:quiz_app_final/data/services/quiz_service.dart';

class QuizListPage extends StatelessWidget {
  const QuizListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final quizService = QuizService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Quiz', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[50],
      ),
      backgroundColor: Colors.blueGrey[50],
      body: StreamBuilder<List<Category>>(
        stream: quizService.getCategories(), // Utilisation du service pour récupérer les catégories
        builder: (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Erreur de chargement des données'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucun quiz trouvé'));
          }

          // Récupération des catégories depuis le snapshot
          List<Category> categories = snapshot.data!;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    // Naviguer vers la page du quiz sélectionné
                    Navigator.pushNamed(context, '/quiz', arguments: categories[index].id);
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    elevation: 4.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: const Icon(
                        Icons.quiz,
                        color: Colors.blueAccent,
                      ),
                      title: Text(
                        categories[index].name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: const Text(
                        'Appuyez pour commencer le quiz',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
