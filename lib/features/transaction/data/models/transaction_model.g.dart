// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TransactionModel _$TransactionModelFromJson(Map<String, dynamic> json) =>
    _TransactionModel(
      id: json['id'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: json['type'] as String,
      date: DateTime.parse(json['date'] as String),
      category: CategoryModel.fromJson(
        json['category'] as Map<String, dynamic>,
      ),
      note: json['note'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$TransactionModelToJson(_TransactionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'type': instance.type,
      'date': instance.date.toIso8601String(),
      'category': instance.category,
      'note': instance.note,
      'created_at': instance.createdAt.toIso8601String(),
    };
