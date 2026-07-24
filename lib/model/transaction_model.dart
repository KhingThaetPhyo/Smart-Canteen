enum TransactionType { received, spent }

class TransactionModel {
  final String id;
  final String title;
  final String subtitle;
  final String amount;
  final String time;
  final TransactionType type;

  TransactionModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.time,
    required this.type,
  });
}
