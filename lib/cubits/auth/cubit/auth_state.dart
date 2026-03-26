part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class UserLoading extends AuthState {}

final class UserLoaded extends AuthState {
  final UserModel user;
  UserLoaded(this.user);
}

final class UserError extends AuthState {
  final String message;
  UserError(this.message);
}

final class UserLoggedOut extends AuthState {}
