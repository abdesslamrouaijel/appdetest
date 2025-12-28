import 'package:flutter/material.dart';
import '../services/fake_notification_service.dart';

class NotificationEmployeePage extends StatefulWidget {
  final String userId;
  const NotificationEmployeePage({super.key, required this.userId});

  @override
  State<NotificationEmployeePage> createState() =>
      _NotificationEmployeePageState();
}

class _NotificationEmployeePageState extends State<NotificationEmployeePage> {
  late Future<List<dynamic>> notifications;

  @override
  void initState() {
    super.initState();
    notifications = FakeNotificationService.getNotifications(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: FutureBuilder<List<dynamic>>(
        future: notifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Aucune notification'));
          }

          final notifs = snapshot.data!;

          return ListView.builder(
            itemCount: notifs.length,
            itemBuilder: (context, index) {
              final n = notifs[index];
              return ListTile(
                title: Text(n['message']),
                subtitle: Text(n['date']),
                leading: Icon(
                  n['status'] == 'unread'
                      ? Icons.notifications_active
                      : Icons.notifications_none,
                  color: n['status'] == 'unread' ? Colors.blue : Colors.grey,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
