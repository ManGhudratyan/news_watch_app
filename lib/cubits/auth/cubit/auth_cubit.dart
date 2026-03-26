import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_watch_app/data/models/user/user_model.dart';
import 'package:news_watch_app/domain/repositories/user_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepository userRepository;

  AuthCubit(this.userRepository) : super(AuthInitial());

  Future<void> getUser() async {
    try {
      emit(UserLoading());
      final user = await userRepository.getUser();
      emit(UserLoaded(user));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  Future<void> addUser(UserModel user) async {
    try {
      emit(UserLoading());
      await userRepository.saveUserData(user);
      final updatedUser = await userRepository.getUser();
      emit(UserLoaded(updatedUser));
    } catch (error) {
      emit(UserError(error.toString()));
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
}
