import 'package:flutter/material.dart';
import 'package:quiz_app_final/data/services/auth_service.dart';

class SignInScreen extends StatefulWidget {
  final Function(int) onNavigateToPage;

  const SignInScreen({super.key, required this.onNavigateToPage});

  @override
  _SignInScreenState createState() => _SignInScreenState(onNavigateToPage: onNavigateToPage);
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  final Function(int) onNavigateToPage;

  _SignInScreenState({required this.onNavigateToPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Connexion',
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
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Se Connecter',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Mot de passe',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      FocusScope.of(context).unfocus();
                      _authService.createUserWithEmail(
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context,
                        onNavigateToPage: onNavigateToPage,
                      );
                      _authService.signInWithEmail(
                        email: _emailController.text,
                        password: _passwordController.text,
                        context: context,
                        onNavigateToPage: onNavigateToPage,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      backgroundColor: Colors.blueAccent[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Se connecter avec un email',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton.icon(
                    onPressed: () {
                      _authService.signInWithGoogle(
                        context: context,
                        onNavigateToPage: onNavigateToPage,
                      );
                    },
                    icon: const Icon(Icons.g_mobiledata, color: Colors.white),
                    label: const Text(
                      'Connexion avec Google',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
