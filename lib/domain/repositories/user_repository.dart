import 'package:news_watch_app/data/models/user/user_model.dart';

abstract class UserRepository {
  Future<void> saveUserData(UserModel user);
  Future<UserModel> getUser();
  Future<void> updateUser(UserModel user);
  Future<bool> isLoggedIn();
  Future<void> userLogout();
}

