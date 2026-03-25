part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class GetUserEvent implements UserEvent {}

final class AddUserEvent implements UserEvent {
  final UserModel user;
  AddUserEvent(this.user);
}

class UpdateUserEvent extends UserEvent {
  final UserModel user;

  UpdateUserEvent(this.user);
}

class UserLogoutEvent extends UserEvent {}
