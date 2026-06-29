import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/category_entity.dart';

part 'category_model.freezed.dart';
part 'category_model.g.dart';

@freezed
abstract class CategoryModel with _$CategoryModel {
  const CategoryModel._();

  const factory CategoryModel({
    @Default('') String id,
    @JsonKey(name: 'user_id') String? userId,
    @Default('') String name,
    @Default('') String type,
    String? icon,
    String? color,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @Default(false) @JsonKey(name: 'is_default') bool isDefault,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  CategoryEntity toEntity() => CategoryEntity(
    id: id,
    userId: userId,
    name: name,
    type: type,
    icon: icon,
    color: color,
    createdAt: createdAt,
    updatedAt: updatedAt,
    isDefault: isDefault,
  );

  factory CategoryModel.fromEntity(CategoryEntity entity) => CategoryModel(
    id: entity.id,
    userId: entity.userId,
    name: entity.name,
    type: entity.type,
    icon: entity.icon,
    color: entity.color,
    createdAt: entity.createdAt,
    updatedAt: entity.updatedAt,
    isDefault: entity.isDefault,
  );
}