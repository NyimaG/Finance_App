class Expense {
  final int? id;
  final String amount;
  final String description;
  final String category;
  final bool isIncome;

  Expense({
    this.id,
    required this.amount,
    required this.description,
    required this.category,
    required this.isIncome,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'description': description,
      'category': category,
      'isIncome': isIncome ? 1 : 0,
    };
  }

  static Expense fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      amount: map['amount'],
      description: map['description'],
      category: map['category'],
      isIncome: map['isIncome'] == 1,
    );
  }
}
