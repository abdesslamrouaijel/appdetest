class Expense {
  final String id;
  final String category;
  final double amount;
  final String description;
  final String date;
  final String status;
  final String receiptPath;
  final String? managerMessage; // ✅ Ajouté

  Expense({
    required this.id,
    required this.category,
    required this.amount,
    required this.description,
    required this.date,
    required this.status,
    required this.receiptPath,
    this.managerMessage,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': category,
        'amount': amount,
        'description': description,
        'date': date,
        'status': status,
        'receiptPath': receiptPath,
        'managerMessage': managerMessage,
      };

  factory Expense.fromJson(Map<String, dynamic> json) => Expense(
        id: json['id'],
        category: json['category'],
        amount: json['amount'],
        description: json['description'],
        date: json['date'],
        status: json['status'],
        receiptPath: json['receiptPath'],
        managerMessage: json['managerMessage'],
      );
}
