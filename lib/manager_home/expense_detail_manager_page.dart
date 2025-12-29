// lib/manager_home/expense_detail_manager_page.dart
import 'package:flutter/material.dart';

class ExpenseDetailManagerPage extends StatefulWidget {
  final Map<String, dynamic> expense;
  final Function(String, String) onStatusChange; // callback pour accepter/rejeter

  const ExpenseDetailManagerPage({
    super.key,
    required this.expense,
    required this.onStatusChange,
  });

  @override
  State<ExpenseDetailManagerPage> createState() => _ExpenseDetailManagerPageState();
}

class _ExpenseDetailManagerPageState extends State<ExpenseDetailManagerPage> {
  late String status;

  @override
  void initState() {
    super.initState();
    status = widget.expense['status'];
  }

  void _updateStatus(String newStatus) {
    setState(() {
      status = newStatus;
    });
    widget.onStatusChange(widget.expense['id'], newStatus);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Dépense ${newStatus == 'approved' ? 'acceptée' : 'rejetée'}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la dépense'),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg4.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            _buildInfoRow('Catégorie', widget.expense['category']),
            const SizedBox(height: 8),
            _buildInfoRow('Montant', '${widget.expense['amount']} MAD'),
            const SizedBox(height: 8),
            _buildInfoRow('Date', widget.expense['date']),
            const SizedBox(height: 8),
            _buildInfoRow('Description', widget.expense['description']),
            const SizedBox(height: 8),
            _buildInfoRow('Commentaire manager', widget.expense['managerComment'] ?? 'Aucun'),
            const SizedBox(height: 16),
            widget.expense['receiptPath'] != null && widget.expense['receiptPath'].isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Reçu:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Image.asset(
                        widget.expense['receiptPath'],
                        errorBuilder: (_, __, ___) => const Text('Image non trouvée'),
                      ),
                    ],
                  )
                : const SizedBox(),
            const SizedBox(height: 24),
            if (status == 'pending')
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _updateStatus('approved'),
                    icon: const Icon(Icons.check),
                    label: const Text('Accepter'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _updateStatus('rejected'),
                    icon: const Icon(Icons.close),
                    label: const Text('Rejeter'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ],
              ),
            if (status != 'pending')
              Center(
                child: Text(
                  'Statut actuel: ${status == 'approved' ? 'Acceptée' : 'Rejetée'}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: status == 'approved' ? Colors.green : Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Flexible(child: Text(value, textAlign: TextAlign.right)),
      ],
    );
  }
}
