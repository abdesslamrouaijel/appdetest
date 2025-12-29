import 'package:flutter/material.dart';
import '../services/fake_expense_service.dart';
import '../employee_home/profile_employee_page.dart';
import '../manager_home/notification_manager_page.dart';
import 'expense_detail_manager_page.dart'; // <-- importer la page de détail

class ManagerHomePage extends StatefulWidget {
  final String managerName;
  final String managerId;

  const ManagerHomePage({
    super.key,
    required this.managerName,
    required this.managerId,
  });

  @override
  State<ManagerHomePage> createState() => _ManagerHomePageState();
}

class _ManagerHomePageState extends State<ManagerHomePage> {
  String searchQuery = '';
  bool isLoading = true;
  List<Map<String, dynamic>> expenses = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  // ================= LOAD EXPENSES =================
  Future<void> _loadExpenses() async {
    try {
      final loadedExpenses = await FakeExpenseService.loadExpenses();
      setState(() {
        expenses = loadedExpenses;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("Erreur chargement des dépenses: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  // ================= UPDATE STATUS =================
  void _updateExpenseStatus(String expenseId, String status) {
    setState(() {
      final index = expenses.indexWhere((e) => e['id'] == expenseId);
      if (index != -1) {
        expenses[index]['status'] = status;
      }
    });
  }

  // ================= CONFIRM REJECTION =================
  Future<void> _confirmReject(String expenseId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmer le rejet'),
        content: const Text('Êtes-vous sûr de vouloir rejeter cette dépense ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Annuler'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Rejeter'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      _updateExpenseStatus(expenseId, 'rejected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildExpenseList(),
          ],
        ),
      ),
    );
  }

  // ================= APP BAR =================
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.grey,
      title: Row(
        children: const [
          Text(
            'Expense',
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Text(
            'Pro',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) =>
                    NotificationManagerPage(managerId: widget.managerId),
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProfileEmployeePage(
                  userName: widget.managerName,
                  email: "manager@example.com",
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // ================= SEARCH BAR =================
  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Rechercher une dépense...',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onChanged: (value) {
        setState(() {
          searchQuery = value;
        });
      },
    );
  }

  // ================= EXPENSE LIST =================
  Widget _buildExpenseList() {
    if (isLoading) {
      return const Expanded(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final filteredExpenses = expenses.where((expense) {
      return expense['category']
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();

    if (filteredExpenses.isEmpty) {
      return const Expanded(
        child: Center(child: Text('Aucune dépense trouvée')),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: filteredExpenses.length,
        itemBuilder: (context, index) {
          final expense = filteredExpenses[index];

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

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              title: Text('${expense['category']} - ${expense['amount']} MAD'),
              subtitle: Text('Statut: $statusFR\nDate: ${expense['date']}'),
              isThreeLine: true,
              // ================= CLIQUE SUR LA DEPENSE =================
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ExpenseDetailManagerPage(
                      expense: expense,
                      onStatusChange: (id, newStatus) {
                        _updateExpenseStatus(id, newStatus);
                      },
                    ),
                  ),
                );
              },
              trailing: expense['status'] == 'pending'
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check, color: Colors.green),
                          onPressed: () =>
                              _updateExpenseStatus(expense['id'], 'approved'),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close, color: Colors.red),
                          onPressed: () => _confirmReject(expense['id']),
                        ),
                      ],
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
