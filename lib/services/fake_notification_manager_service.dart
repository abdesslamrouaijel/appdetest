import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart'; // pour debugPrint

class FakeNotificationManagerService {
  static Future<List<Map<String, dynamic>>> getNotificationsByManagerId(String managerId) async {
    try {
      final String jsonString = await rootBundle.loadString('assets/data/notifications_manager.json');
      final List<dynamic> data = json.decode(jsonString);

      // Filtrer les notifications pour ce manager
      return data
          .where((n) => n['managerId'] == managerId)
          .map((n) => Map<String, dynamic>.from(n))
          .toList();
    } catch (e) {
      debugPrint('Erreur chargement notifications manager: $e');
      return [];
    }
  }
}
