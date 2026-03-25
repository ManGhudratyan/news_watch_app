import 'package:news_watch_app/data/models/user/user_model.dart';
import 'package:news_watch_app/domain/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepositoryImp implements UserRepository {
  @override
  Future<void> saveUserData(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', user.username);
    await prefs.setString('email', user.email);
    await prefs.setString('phone', user.phoneNumber ?? '');
    await prefs.setString('password', user.password ?? '');
    await prefs.setString('userId', user.userId ?? '');
  }

  @override
  Future<UserModel> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    return UserModel(
      username: prefs.getString('username') ?? '',
      email: prefs.getString('email') ?? '',
      phoneNumber: prefs.getString('phone') ?? '',
      password: prefs.getString('password') ?? '',
      userId: prefs.getString('userId') ?? '',
    );
  }

  @override
  Future<void> updateUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', user.username);
    await prefs.setString('email', user.email);
    await prefs.setString('phone', user.phoneNumber ?? '');
    await prefs.setString('password', user.password ?? '');
    if (user.imagePath != null) {
      await prefs.setString('imagePath', user.imagePath!);
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    return userId != null;
  }

  @override
  Future<void> userLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
  }
}
