import 'package:ruay_jung/src/features/categories/domain/entities/transaction_kind.dart';

class Category {
  const Category({required this.id, required this.name, required this.kind});

  final String id;
  final String name;
  final TransactionKind kind;
}
