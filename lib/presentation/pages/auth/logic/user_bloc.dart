// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:news_watch_app/data/models/user/user_model.dart';
import 'package:news_watch_app/domain/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<GetUserEvent>(_mapGetUserEventToState);
    on<AddUserEvent>(_mapAddUserEventToState);
    on<UpdateUserEvent>(_mapUpdateUserEvent);
    on<UserLogoutEvent>(_mapUserLogoutEventToState);
  }

  FutureOr<void> _mapGetUserEventToState(
    GetUserEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(UserLoading());
      final user = await userRepository.getUser();
      emit(UserLoaded(user));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  FutureOr<void> _mapAddUserEventToState(
    AddUserEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(UserLoading());
      await userRepository.saveUserData(event.user);
      final updatedUser = await userRepository.getUser();
      emit(UserLoaded(updatedUser));
    } catch (error) {
      emit(UserError(error.toString()));
    }
  }

  FutureOr<void> _mapUpdateUserEvent(
    UpdateUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      await userRepository.updateUser(event.user);
      emit(UserLoaded(event.user));
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }

  FutureOr<void> _mapUserLogoutEventToState(
    UserLogoutEvent event,
    Emitter<UserState> emit,
  ) async {
    try {
      emit(UserLoading());
      await userRepository.userLogout();
      emit(UserLoggedOut());
    } catch (e) {
      emit(UserError(e.toString()));
    }
  }
}
