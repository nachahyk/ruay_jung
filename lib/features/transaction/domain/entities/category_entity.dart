import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String id;
  final String? userId;
  final String name;
  final String type;
  final String? icon;
  final String? color;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isDefault;

  const CategoryEntity({
    required this.id,
    this.userId,
    required this.name,
    required this.type,
    this.icon,
    this.color,
    this.createdAt,
    this.updatedAt,
    this.isDefault = false,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        name,
        type,
        icon,
        color,
        createdAt,
        updatedAt,
        isDefault,
      ];
}
