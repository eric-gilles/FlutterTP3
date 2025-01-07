import 'package:flutter/material.dart';
import 'package:quiz_app_final/data/services/auth_service.dart';
import 'package:quiz_app_final/presentation/widgets/register_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  _RegisterPageState();

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
          'S\'incrire',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[50],
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(color: Colors.blueGrey[50]),
        child: Center(
          child: RegisterWidget(),
        ),
      ),
    );
  }
}
