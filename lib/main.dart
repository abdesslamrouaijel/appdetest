import 'package:flutter/material.dart';
import 'login/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  // 🔹 Méthode statique pour changer le thème depuis n'importe quelle page
  static void setTheme(BuildContext context, ThemeMode themeMode) {
    final _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.changeTheme(themeMode);
  }
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Gestion',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode,
      home: const LoginPage(),
    );
  }
}
