import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class QuizProfilePage extends StatelessWidget {
  final Function(int) onNavigateToPage;

  const QuizProfilePage({super.key, required this.onNavigateToPage});

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[50],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blueGrey[50],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (user != null) ...[
                const Text(
                  'Bienvenue sur votre profil !',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (user.photoURL != null)  ...[
                  const SizedBox(height: 20),
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(user.photoURL!),
                  ),
                ],
                if (user.displayName != null && user.photoURL != null) ...[
                  const SizedBox(height: 20),
                  Text(
                    'Nom : ${user.displayName!}',
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black87,
                    ),
                  ),
                ],
                const SizedBox(height: 20),
                Text(
                  'Email : ${user.email}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    onNavigateToPage(2);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                    backgroundColor: Colors.blueAccent[700],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Se déconnecter',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ] else ...[
                const Text(
                  'Vous n\'êtes pas connecté',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}