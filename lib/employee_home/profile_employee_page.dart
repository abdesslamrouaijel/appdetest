import 'package:flutter/material.dart';
import '../../login/login.dart';
import '../../main.dart'; // 🔹 pour accéder à MyApp.setTheme

class ProfileEmployeePage extends StatefulWidget {
  final String userName;
  final String email;

  const ProfileEmployeePage({super.key, required this.userName, required this.email});

  @override
  State<ProfileEmployeePage> createState() => _ProfileEmployeePageState();
}

class _ProfileEmployeePageState extends State<ProfileEmployeePage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg3.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Nom', widget.userName),
            const SizedBox(height: 16),
            _buildInfoRow('Email', widget.email),
            const SizedBox(height: 16),
            _buildSwitchRow('Mode sombre', isDarkMode, (val) {
              setState(() {
                isDarkMode = val;
              });
              // 🔹 changer le thème global
              MyApp.setTheme(context, val ? ThemeMode.dark : ThemeMode.light);
            }),
            const SizedBox(height: 16),
            _buildInfoRow('Langue', 'Français'),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _logout,
                child: const Text('Déconnexion'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
        Text(value, style: const TextStyle(fontSize: 16, color: Colors.white)),
      ],
    );
  }

  Widget _buildSwitchRow(String label, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
        Switch(value: value, onChanged: onChanged),
      ],
    );
  }

  void _logout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginPage()),
      (route) => false,
    );
  }
}
