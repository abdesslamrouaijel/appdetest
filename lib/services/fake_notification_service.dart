import 'dart:convert';
import 'package:flutter/services.dart';

class FakeNotificationService {
  static Future<List<Map<String, dynamic>>> getNotificationsByUserId(
      String userId) async {
    final String jsonString =
        await rootBundle.loadString('assets/data/notifications.json');

    final List<dynamic> jsonData = jsonDecode(jsonString);

    return jsonData
        .where((n) => n['userId'] == userId)
        .map((n) => Map<String, dynamic>.from(n))
        .toList();
  }
}
