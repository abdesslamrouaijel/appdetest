import 'package:flutter/material.dart';
import '../services/fake_notification_service.dart';

class NotificationEmployeePage extends StatefulWidget {
  final String userId;

  const NotificationEmployeePage({
    super.key,
    required this.userId,
  });

  @override
  State<NotificationEmployeePage> createState() =>
      _NotificationEmployeePageState();
}

class _NotificationEmployeePageState extends State<NotificationEmployeePage> {
  late Future<List<Map<String, dynamic>>> notifications;

  @override
  void initState() {
    super.initState();
    notifications =
        FakeNotificationService.getNotificationsByUserId(widget.userId);
    notifications.then((list) {
      print("Notifications chargées pour ${widget.userId}: $list");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications'),
      backgroundColor: Colors.grey,),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: notifications,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'Aucune notification',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            final notifs = snapshot.data!;

            return ListView.builder(
              itemCount: notifs.length,
              itemBuilder: (context, index) {
                final n = notifs[index];

                IconData icon;
                Color color;

                switch (n['status']) {
                  case 'approved':
                    icon = Icons.check_circle;
                    color = Colors.green;
                    break;
                  case 'rejected':
                    icon = Icons.cancel;
                    color = Colors.red;
                    break;
                  default:
                    icon = Icons.hourglass_top;
                    color = Colors.orange;
                }

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: Icon(icon, color: color),
                    title: Text(n['title']),
                    subtitle: Text(
                      '${n['message']}\n${n['date']}',
                    ),
                    isThreeLine: true,
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
