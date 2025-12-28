// lib/employee_home/expense_detail_page.dart
import 'package:flutter/material.dart';
import 'app_styles.dart';

class ExpenseDetailPage extends StatelessWidget {
  final Map<String, dynamic> expense;

  const ExpenseDetailPage({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    String statusFR;
    switch (expense['status']) {
      case 'pending':
        statusFR = 'En attente';
        break;
      case 'approved':
        statusFR = 'Acceptée';
        break;
      case 'rejected':
        statusFR = 'Rejetée';
        break;
      default:
        statusFR = expense['status'];
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Détails de la dépense')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Catégorie: ${expense['category']}', style: AppStyles.expenseCategory),
            const SizedBox(height: 8),
            Text('Montant: ${expense['amount']} MAD', style: AppStyles.expenseAmount),
            const SizedBox(height: 8),
            Text('Date: ${expense['date']}', style: AppStyles.expenseDate),
            const SizedBox(height: 8),
            Text('Description: ${expense['description'] ?? "-"}'),
            const SizedBox(height: 8),
            Text('Statut: $statusFR'),
            const SizedBox(height: 8),
            Text('Commentaire du manager: ${expense['managerComment'] ?? "-"}'),
          ],
        ),
      ),
    );
  }
}
