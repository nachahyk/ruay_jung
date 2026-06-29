import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/profile_entity.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
abstract class ProfileModel with _$ProfileModel {
  const ProfileModel._();

  const factory ProfileModel({
    @Default('') String id,
    @Default('') String email,
    @JsonKey(name: 'full_name') String? fullName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _ProfileModel;

  factory ProfileModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileModelFromJson(json);

  ProfileEntity toEntity() => ProfileEntity(
        id: id,
        email: email,
        fullName: fullName,
        avatarUrl: avatarUrl,
      );

  factory ProfileModel.fromEntity(ProfileEntity entity) => ProfileModel(
        id: entity.id,
        email: entity.email,
        fullName: entity.fullName,
        avatarUrl: entity.avatarUrl,
      );
}
