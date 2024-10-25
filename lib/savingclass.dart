class SavingsGoal {
  String name;
  int targetAmount;
  int savedAmount;

  SavingsGoal(
      {required this.name,
      required this.targetAmount,
      required this.savedAmount});

  double get progress {
    if (targetAmount <= 0) return 0.0; // Prevent division by zero
    return savedAmount / targetAmount;
  }
}
