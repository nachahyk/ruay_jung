import 'package:ruay_jung/src/features/categories/domain/entities/transaction_kind.dart';

/// One logged transaction — [amount] is always positive; [kind] says
/// whether it added to or subtracted from [accountId]'s balance.
class Transaction {
  const Transaction({
    required this.id,
    required this.accountId,
    required this.categoryId,
    required this.kind,
    required this.amount,
    required this.occurredOn,
    this.note,
  });

  final String id;
  final String accountId;
  final String categoryId;
  final TransactionKind kind;
  final double amount;
  final DateTime occurredOn;
  final String? note;

  /// Signed for balance/total math — positive for income, negative for
  /// expense — so a caller can just sum this across a list.
  double get signedAmount => kind == TransactionKind.income ? amount : -amount;
}
