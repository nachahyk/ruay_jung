import 'package:equatable/equatable.dart';
import 'category_entity.dart';

class TransactionEntity extends Equatable {
  final String id;
  final double amount;
  final String type; // 'expense' or 'income'
  final DateTime date;
  final CategoryEntity category;
  final String? note;
  final DateTime createdAt;

  const TransactionEntity({
    required this.id,
    required this.amount,
    required this.type,
    required this.date,
    required this.category,
    this.note,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id, amount, type, date, category, note, createdAt];
}
