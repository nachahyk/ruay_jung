import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/transaction_entity.dart';
import 'category_model.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
abstract class TransactionModel with _$TransactionModel {
  const TransactionModel._();

  const factory TransactionModel({
    required String id,
    required double amount,
    required String type,
    required DateTime date,
    required CategoryModel category,
    String? note,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _TransactionModel;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionModelFromJson(json);

  TransactionEntity toEntity() => TransactionEntity(
        id: id,
        amount: amount,
        type: type,
        date: date,
        category: category.toEntity(),
        note: note,
        createdAt: createdAt,
      );

  factory TransactionModel.fromEntity(TransactionEntity entity) => TransactionModel(
        id: entity.id,
        amount: entity.amount,
        type: entity.type,
        date: entity.date,
        category: CategoryModel.fromEntity(entity.category),
        note: entity.note,
        createdAt: entity.createdAt,
      );
}
