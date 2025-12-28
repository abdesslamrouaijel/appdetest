import 'dart:convert';
import 'package:flutter/services.dart';

class FakeExpenseService {
  /// Charge les dépenses depuis le fichier assets/data/expenses.json
  static Future<List<Map<String, dynamic>>> loadExpenses() async {
    final String jsonString =
        await rootBundle.loadString('assets/data/expenses.json');
    final List<dynamic> data = jsonDecode(jsonString);

    return data.map((e) => Map<String, dynamic>.from(e)).toList();
  }
}
