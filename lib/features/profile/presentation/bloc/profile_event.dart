part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

final class ProfileFetchRequested extends ProfileEvent {
  final String userId;

  const ProfileFetchRequested(this.userId);

  @override
  List<Object> get props => [userId];
}
