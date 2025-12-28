import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';

class ExpenseDetailPage extends StatelessWidget {
  final Map<String, String> expense;
  final String managerMessage;

  const ExpenseDetailPage({
    super.key,
    required this.expense,
    this.managerMessage = '',
  });

  Color getStatusColor(String status) {
    switch (status) {
      case 'Pending':
        return Colors.yellow;
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la dépense'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.grey[700],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg2.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black54,
              BlendMode.darken,
            ),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Catégorie
              const Text('Catégorie',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 4),
              Text(expense['category'] ?? '', style: const TextStyle(color: Colors.white)),

              const SizedBox(height: 16),

              /// Montant
              const Text('Montant',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 4),
              Text(expense['amount'] ?? '', style: const TextStyle(color: Colors.white)),

              const SizedBox(height: 16),

              /// Date
              const Text('Date',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 4),
              Text(expense['date'] ?? '', style: const TextStyle(color: Colors.white)),

              const SizedBox(height: 16),

              /// Statut
              const Text('Statut',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 4),
              Text(expense['status'] ?? '',
                  style: TextStyle(
                      color: getStatusColor(expense['status'] ?? ''),
                      fontWeight: FontWeight.bold)),

              const SizedBox(height: 16),

              /// Reçu
              const Text('Reçu',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
              const SizedBox(height: 8),
              expense['receipt'] != null
                  ? Image.asset(
                      expense['receipt']!,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, size: 50),
                    ),

              const SizedBox(height: 16),

              /// Message du manager
              if (managerMessage.isNotEmpty)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Message du manager',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    const SizedBox(height: 4),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(managerMessage, style: const TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
