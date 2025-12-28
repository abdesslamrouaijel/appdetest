import 'package:flutter/material.dart';
import 'app_styles.dart';
import 'expense_card.dart';
import 'notification_employee_page.dart';
import 'profile_employee_page.dart';
import 'new_expense_page.dart';
import '../services/fake_expense_service.dart';
import 'expense_detail_page.dart';

class EmployeeHomePage extends StatefulWidget {
  final String userName;
  final String userId;
  final String userEmail;

  const EmployeeHomePage({
    super.key,
    required this.userName,
    required this.userId,
    required this.userEmail,
  });

  @override
  State<EmployeeHomePage> createState() => _EmployeeHomePageState();
}

class _EmployeeHomePageState extends State<EmployeeHomePage> {
  String searchQuery = '';
  String selectedStatus = 'Tous';
  List<Map<String, dynamic>> expenses = [];
  bool isLoading = true;

  final List<String> statusList = [
    'Tous',
    'En attente',
    'Acceptée',
    'Rejetée',
  ];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: _buildAddButton(),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreeting(),
            const SizedBox(height: 16),
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildStatusFilter(),
            const SizedBox(height: 16),
            _buildExpenseList(),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text('Mes dépenses'),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => NotificationEmployeePage(userId: widget.userId),
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
                  userName: widget.userName,
                  email: widget.userEmail,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    return Text(
      'Bonjour ${widget.userName} 👋',
      style: AppStyles.greetingText,
    );
  }

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

  Widget _buildStatusFilter() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: statusList.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final status = statusList[index];
          final isSelected = status == selectedStatus;
          return ChoiceChip(
            label: Text(status),
            selected: isSelected,
            onSelected: (_) {
              setState(() {
                selectedStatus = status;
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildExpenseList() {
    if (isLoading) {
      return const Expanded(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final filteredExpenses = expenses.where((expense) {
      final matchesUser = expense['userId'].toString().trim().toLowerCase() ==
          widget.userId.trim().toLowerCase();

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

      final matchesStatus =
          selectedStatus == 'Tous' || statusFR == selectedStatus;
      final matchesSearch = expense['category']
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      return matchesUser && matchesStatus && matchesSearch;
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

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ExpenseDetailPage(expense: expense),
                ),
              );
            },
            child: ExpenseCard(
              category: expense['category'],
              amount: (expense['amount'] as num).toDouble(),
              status: statusFR,
              date: expense['date'],
            ),
          );
        },
      ),
    );
  }

  FloatingActionButton _buildAddButton() {
    return FloatingActionButton(
      onPressed: () async {
        final newExpense = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => NewExpensePage(userId: widget.userId),
          ),
        );
        if (newExpense != null && newExpense is Map<String, dynamic>) {
          setState(() {
            expenses.add(newExpense);
          });
        }
      },
      child: const Icon(Icons.add),
    );
  }
}
