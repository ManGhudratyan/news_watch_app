// // ignore_for_file: depend_on_referenced_packages

// import 'package:bloc/bloc.dart';
// import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
// import 'package:news_watch_app/data/models/user/user_model.dart';
// import 'package:news_watch_app/domain/repositories/user_repository.dart';

// class AuthCubit extends Cubit<AuthState> {
//   final UserRepository userRepository;

//   AuthCubit(this.userRepository) : super(AuthState());

//   Future<void> addUser(UserModel user) async {
//     try {
//       emit(state.copyWith(loading: true));
//       await userRepository.saveUserData(user);
//       final updatedUser = await userRepository.getUserByEmailAndPassword(
//         user.email,
//         user.password!,
//       );
//       if (updatedUser != null) {
//         await userRepository.saveLoggedInUser(updatedUser.userId);
//         emit(state.copyWith(user: updatedUser));
//       }
//     } catch (error) {
//       emit(state.copyWith(error: error.toString()));
//     }
//   }

//   Future<void> signIn(String email, String password) async {
//     try {
//       emit(state.copyWith(loading: true));
//       final user = await userRepository.getUserByEmailAndPassword(
//         email,
//         password,
//       );
//       if (user != null) {
//         await userRepository.saveLoggedInUser(user.userId);
//         emit(state.copyWith(user: user));
//       } else {
//         emit(state.copyWith(error: "Email or password incorrect"));
//       }
//     } catch (error) {
//       emit(state.copyWith(error: error.toString()));
//     }
//   }

//   Future<void> updateUser(UserModel user) async {
//     emit(state.copyWith(loading: true));
//     try {
//       await userRepository.updateUser(user);
//       emit(state.copyWith(user: user, loading: false));
//     } catch (error) {
//       emit(state.copyWith(error: error.toString()));
//     }
//   }

//   Future<void> userlogOut() async {
//     try {
//       emit(state.copyWith(loading: true));
//       await userRepository.userLogout();
//       emit(state.copyWith(loggedOut: true));
//     } catch (error) {
//       emit(state.copyWith(error: error.toString()));
//     }
//   }

//   Future<void> getLoggedInUser() async {
//     try {
//       emit(state.copyWith(loading: true));
//       final user = await userRepository.getLoggedInUser();
//       if (user != null) {
//         emit(state.copyWith(user: user));
//       } else {
//         emit(state.copyWith(loggedOut: true));
//       }
//     } catch (error) {
//       emit(state.copyWith(error: error.toString()));
//     }
//   }

//   Future<void> resetPassword(String email, String newPassword) async {
//     try {
//       emit(state.copyWith(loading: true));
//       final user = await userRepository.getUserByEmail(email);
//       if (user == null) {
//         emit(state.copyWith(error: "User not found"));
//         return;
//       }
//       final updatedUser = user.copyWith(password: newPassword);
//       await userRepository.updateUser(updatedUser);
//       emit(state.copyWith(user: updatedUser));
//     } catch (error) {
//       emit(state.copyWith(error: error.toString()));
//     }
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
import 'package:news_watch_app/data/models/user/user_model.dart';
import 'package:news_watch_app/domain/repositories/user_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  final UserRepository userRepository;

  AuthCubit(this.userRepository) : super(AuthState());

  Future<void> addUser(UserModel user) async {
    try {
      emit(state.copyWith(loading: true, error: '', loggedOut: false));

      await userRepository.saveUserData(user);

      final updatedUser = await userRepository.getUserByEmailAndPassword(
        user.email,
        user.password!,
      );

      if (updatedUser != null) {
        await userRepository.saveLoggedInUser(updatedUser.userId);
        emit(
          state.copyWith(
            user: updatedUser,
            loading: false,
            error: '',
            loggedOut: false,
          ),
        );
      } else {
        emit(state.copyWith(loading: false, error: 'User could not be loaded'));
      }
    } catch (error) {
      emit(state.copyWith(loading: false, error: error.toString()));
    }
  }

  Future<void> signIn(String email, String password) async {
    try {
      emit(state.copyWith(loading: true, error: '', loggedOut: false));

      final user = await userRepository.getUserByEmailAndPassword(
        email,
        password,
      );

      if (user != null) {
        await userRepository.saveLoggedInUser(user.userId);
        emit(
          state.copyWith(
            user: user,
            loading: false,
            error: '',
            loggedOut: false,
          ),
        );
      } else {
        emit(
          state.copyWith(loading: false, error: "Email or password incorrect"),
        );
      }
    } catch (error) {
      emit(state.copyWith(loading: false, error: error.toString()));
    }
  }

  Future<void> updateUser(UserModel user) async {
    emit(state.copyWith(loading: true, error: ''));
    try {
      await userRepository.updateUser(user);
      emit(
        state.copyWith(user: user, loading: false, error: '', loggedOut: false),
      );
    } catch (error) {
      emit(state.copyWith(loading: false, error: error.toString()));
    }
  }

  Future<void> userlogOut() async {
    try {
      emit(state.copyWith(loading: true, error: ''));
      await userRepository.userLogout();
      emit(
        state.copyWith(user: null, loading: false, loggedOut: true, error: ''),
      );
    } catch (error) {
      emit(state.copyWith(loading: false, error: error.toString()));
    }
  }

  Future<void> getLoggedInUser() async {
    try {
      emit(state.copyWith(loading: true, error: ''));
      final user = await userRepository.getLoggedInUser();

      if (user != null) {
        emit(
          state.copyWith(
            user: user,
            loading: false,
            loggedOut: false,
            error: '',
          ),
        );
      } else {
        emit(
          state.copyWith(
            user: null,
            loading: false,
            loggedOut: true,
            error: '',
          ),
        );
      }
    } catch (error) {
      emit(state.copyWith(loading: false, error: error.toString()));
    }
  }

  Future<void> resetPassword(String email, String newPassword) async {
    try {
      emit(state.copyWith(loading: true, error: ''));
      final user = await userRepository.getUserByEmail(email);

      if (user == null) {
        emit(state.copyWith(loading: false, error: "User not found"));
        return;
      }

      final updatedUser = user.copyWith(password: newPassword);
      await userRepository.updateUser(updatedUser);

      emit(
        state.copyWith(
          user: updatedUser,
          loading: false,
          error: '',
          loggedOut: false,
        ),
      );
    } catch (error) {
      emit(state.copyWith(loading: false, error: error.toString()));
    }
  }
}
