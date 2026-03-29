// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_watch_app/data/models/user/user_model.dart';
import 'package:news_watch_app/domain/repositories/user_repository.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepository userRepository;

  AuthCubit(this.userRepository) : super(AuthInitial());

  Future<void> addUser(UserModel user) async {
    try {
      emit(UserLoading());
      await userRepository.saveUserData(user);
      final updatedUser = await userRepository.getUserByEmailAndPassword(
        user.email,
        user.password!,
      );
      if (updatedUser != null) {
        await userRepository.saveLoggedInUser(updatedUser.userId);
        emit(UserLoaded(updatedUser));
      }
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      emit(UserLoading());
      final user = await userRepository.getUserByEmailAndPassword(
        email,
        password,
      );
      if (user != null) {
        await userRepository.saveLoggedInUser(user.userId);
        emit(UserLoaded(user));
      } else {
        emit(UserError("Email or password incorrect"));
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> updateUser(UserModel user) async {
    emit(UserLoading());
    try {
      await userRepository.updateUser(user);
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> userlogOut() async {
    try {
      emit(UserLoading());
      await userRepository.userLogout();
      emit(UserLoggedOut());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> getLoggedInUser() async {
    try {
      emit(UserLoading());
      final user = await userRepository.getLoggedInUser();
      if (user != null) {
        emit(UserLoaded(user));
      } else {
        emit(UserLoggedOut());
      }
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  Future<void> resetPassword(String email, String newPassword) async {
    try {
      emit(UserLoading());
      final user = await userRepository.getUserByEmail(email);
      if (user == null) {
        emit(UserError("User not found"));
        return;
      }
      final updatedUser = user.copyWith(password: newPassword);
      await userRepository.updateUser(updatedUser);
      emit(UserLoaded(updatedUser));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
