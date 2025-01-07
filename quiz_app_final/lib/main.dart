import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_app_final/data/services/auth_service.dart';

import 'package:quiz_app_final/presentation/screens/quiz_connect_page.dart';
import 'package:quiz_app_final/presentation/screens/quiz_form_page.dart';
import 'package:quiz_app_final/presentation/screens/home_page.dart';
import 'package:quiz_app_final/presentation/screens/quiz_list_page_.dart';
import 'package:quiz_app_final/presentation/screens/quiz_page.dart';
import 'package:quiz_app_final/presentation/screens/profile_page.dart';
import 'package:quiz_app_final/presentation/screens/quiz_result_page.dart';
import 'package:quiz_app_final/presentation/screens/signin_page.dart';
import 'package:quiz_app_final/presentation/screens/register_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  AuthService authService = AuthService();
  runApp(QuizApp(authService: authService));
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key, required this.authService});
  final AuthService authService;

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setCurrentPage(0);
      }
    });
  }

  void setCurrentPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  Future<bool> isAuthenticated() async {
    return widget.authService.isLoggedIn;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder<bool>(
        future: isAuthenticated(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data == true) {
            return Scaffold(
              body: [
                QuizHomePage(onNavigateToPage: setCurrentPage),
                const QuizListPage(),
                QuizProfilePage(onNavigateToPage: setCurrentPage),
                QuizFormPage(onNavigateToPage: setCurrentPage),
              ][currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentIndex,
                selectedItemColor: Colors.blueAccent,
                unselectedItemColor: Colors.grey,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Accueil',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: 'Liste des Quiz',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person),
                    label: 'Profil',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    label: 'Ajouter un Quiz',
                  )
                ],
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            );
          } else {
            return Scaffold(
              body: [
                QuizHomePage(onNavigateToPage: setCurrentPage),
                const QuizListPage(),
                const ConnectionPage(),
              ][currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentIndex,
                selectedItemColor: Colors.blueAccent,
                unselectedItemColor: Colors.grey,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Accueil',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.list),
                    label: 'Liste des Quiz',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.login),
                    label: 'Se connecter',
                  ),
                ],
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
            );
          }
        },
      ),
      routes: {
        '/signin': (context) => const SignInPage(),
        '/register': (context) => const RegisterPage(),
        '/quiz': (context) {
          final String categoryIndex = ModalRoute.of(context)?.settings.arguments as String;
          return QuizPage(categoryIndex: categoryIndex, title: 'Questions',);
        },
        '/result': (context) => const QuizResultPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}