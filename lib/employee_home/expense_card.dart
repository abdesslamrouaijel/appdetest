import 'package:flutter/material.dart';
import 'app_styles.dart';

class ExpenseCard extends StatelessWidget {
  final String category;
  final double amount;
  final String status; // En attente | Acceptée | Rejetée
  final String date;

  const ExpenseCard({
    super.key,
    required this.category,
    required this.amount,
    required this.status,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _leftSection(),
            _rightSection(),
          ],
        ),
      ),
    );
  }

  // ================= LEFT =================

  Widget _leftSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: AppStyles.expenseCategory,
        ),
        const SizedBox(height: 4),
        Text(
          date,
          style: AppStyles.expenseDate,
        ),
      ],
    );
  }

  // ================= RIGHT =================

  Widget _rightSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '${amount.toStringAsFixed(2)} MAD',
          style: AppStyles.expenseAmount,
        ),
        const SizedBox(height: 6),
        _buildStatusChip(),
      ],
    );
  }

  // ================= STATUS =================

  Widget _buildStatusChip() {
    Color color;

    switch (status) {
      case 'Acceptée':
        color = Colors.green;
        break;
      case 'Rejetée':
        color = Colors.red;
        break;
      default:
        color = Colors.orange;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }
}
