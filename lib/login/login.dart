import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../employee_home/employee_home_page.dart';
import '../manager_home/manager_home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Connexion',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            _field(emailController, 'Email', Icons.email),
            const SizedBox(height: 16),
            _field(passwordController, 'Mot de passe', Icons.lock, obscure: true),
            if (errorMessage != null) ...[
              const SizedBox(height: 12),
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            ],
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text('Se connecter'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String hint,
    IconData icon, {
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  Future<void> _login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      final String jsonString =
          await rootBundle.loadString('assets/data/users.json');
      final List<dynamic> users = jsonDecode(jsonString);

      Map<String, dynamic>? foundUser;
      for (final user in users) {
        if (user['email'] == email && user['password'] == password) {
          foundUser = user;
          break;
        }
      }

      if (foundUser == null) {
        if (!mounted) return;
        setState(() {
          errorMessage = 'Email ou mot de passe incorrect';
        });
        return;
      }

      if (!mounted) return;

      final String userName = foundUser['name'] ?? 'Utilisateur';
      final String userId = (foundUser['id'] ?? '').trim().toLowerCase();
      final String userEmail = foundUser['email'] ?? '';

      if (foundUser['role'] == 'employee') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => EmployeeHomePage(
              userName: userName,
              userId: userId,
              userEmail: userEmail,
            ),
          ),
        );
      } else if (foundUser['role'] == 'manager') {
        Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => ManagerHomePage(
      managerName: userName,
      managerId: userId,
    ),
  ),
);

      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        errorMessage = 'Erreur lors de la connexion';
      });
    }
  }
}
