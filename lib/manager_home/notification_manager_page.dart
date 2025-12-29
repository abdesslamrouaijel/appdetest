import 'package:flutter/material.dart';
import '../services/fake_notification_manager_service.dart';

class NotificationManagerPage extends StatefulWidget {
  final String managerId;

  const NotificationManagerPage({super.key, required this.managerId});

  @override
  State<NotificationManagerPage> createState() => _NotificationManagerPageState();
}

class _NotificationManagerPageState extends State<NotificationManagerPage> {
  late Future<List<Map<String, dynamic>>> _notificationsFuture;

  @override
  void initState() {
    super.initState();
    _notificationsFuture = FakeNotificationManagerService.getNotificationsByManagerId(widget.managerId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications'),
      backgroundColor: Colors.grey),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: _notificationsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erreur: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('Aucune notification'));
            }

            final notifications = snapshot.data!;
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final n = notifications[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    title: Text(n['message']),
                    subtitle: Text('Dépense: ${n['expenseId']}'),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
