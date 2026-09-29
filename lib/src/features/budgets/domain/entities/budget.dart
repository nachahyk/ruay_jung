/// How much is planned to be spent on one expense category in one month.
/// [month] is always normalized to the 1st of that month.
class Budget {
  const Budget({required this.id, required this.categoryId, required this.month, required this.amount});

  final String id;
  final String categoryId;
  final DateTime month;
  final double amount;
}
