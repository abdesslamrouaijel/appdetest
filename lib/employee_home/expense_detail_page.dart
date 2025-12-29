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
      appBar: AppBar(
        title: const Text('Détails de la dépense'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // 🔹 Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg1.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 Overlay pour lisibilité
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.2),
            ),
          ),

          // 🔹 Contenu
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoText(
                  'Catégorie',
                  expense['category'],
                  AppStyles.expenseCategory,
                ),
                const SizedBox(height: 12),

                _infoText(
                  'Montant',
                  '${expense['amount']} MAD',
                  AppStyles.expenseAmount,
                ),
                const SizedBox(height: 12),

                _infoText(
                  'Date',
                  expense['date'],
                  AppStyles.expenseDate,
                ),
                const SizedBox(height: 12),

                _infoText(
                  'Description',
                  expense['description'] ?? '-',
                  AppStyles.expenseDate,
                ),
                const SizedBox(height: 12),

                _infoText(
                  'Statut',
                  statusFR,
                  AppStyles.expenseDate,
                ),
                const SizedBox(height: 12),

                _infoText(
                  'Commentaire du manager',
                  expense['managerComment'] ?? '-',
                  AppStyles.expenseDate,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Widget réutilisable pour affichage propre
  Widget _infoText(String label, String value, TextStyle style) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label : ',
            style: style.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: value,
            style: style.copyWith(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
