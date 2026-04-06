import 'package:news_watch_app/data/models/user/user_model.dart';

abstract class UserRepository {
  Future<void> saveUserData(UserModel user);
  Future<UserModel?> getUserByEmailAndPassword(String email, String password);
  Future<void> updateUser(UserModel user);
  Future<void> saveLoggedInUser(String? userId);
  Future<UserModel?> getLoggedInUser();
  Future<void> userLogout();
  Future<bool> isLoggedIn();
  Future<UserModel?> getUserByEmail(String email);
}
