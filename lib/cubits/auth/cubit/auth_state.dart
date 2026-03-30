import 'package:equatable/equatable.dart';
import 'package:news_watch_app/data/models/user/user_model.dart';

class AuthState extends Equatable {
  final UserModel? user;
  final bool loading;
  final String? error;
  final bool? loggedOut;
  const AuthState({this.user, this.loading = true, this.error, this.loggedOut});

  AuthState copyWith({
    UserModel? user,
    bool? loading,
    String? error,
    bool? loggedOut,
  }) {
    return AuthState(
      user: user ?? this.user,
      loading: loading ?? this.loading,
      error: error ?? this.error,
      loggedOut: loggedOut ?? this.loggedOut,
    );
  }

  @override
  List<Object?> get props => [user, loading, error, loggedOut];
}
