import 'dart:convert';
import 'package:flutter/services.dart';

class FakeNotificationService {
  static Future<List<dynamic>> getNotifications(String userId) async {
    final String jsonString =
        await rootBundle.loadString('assets/data/notifications.json');
    final List<dynamic> notifications = jsonDecode(jsonString);

    // Retourne uniquement les notifications de l'employee
    return notifications.where((n) => n['userId'] == userId).toList();
  }
}
