import 'package:flutter/material.dart';
import 'package:quiz_app_final/data/services/auth_service.dart';
import 'package:quiz_app_final/presentation/widgets/sign_in_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  @override
  void initState() {
    super.initState();
    // Vérifie si l'utilisateur est déjà connecté
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authService = AuthService();
      if (authService.isLoggedIn) {
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Se connecter',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[50],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(color: Colors.blueGrey[50]),
        child: Center(
          child: SignInWidget(),
        ),
      ),
    );
  }
}
