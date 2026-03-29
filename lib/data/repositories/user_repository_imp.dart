import 'dart:convert';
import 'package:news_watch_app/data/models/user/user_model.dart';
import 'package:news_watch_app/domain/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UserRepositoryImp implements UserRepository {
  final String usersKey = 'users';
  final String loggedInKey = 'loggedInUserId';

  Future<List<UserModel>> _getAllUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString(usersKey);
    if (usersJson == null) return [];
    final List decoded = jsonDecode(usersJson);
    return decoded.map((e) => UserModel.fromJson(e)).toList();
  }

  Future<void> _saveAllUsers(List<UserModel> users) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(users.map((e) => e.toJson()).toList());
    await prefs.setString(usersKey, encoded);
  }

  @override
  Future<void> saveUserData(UserModel user) async {
    final allUsers = await _getAllUsers();

    if (allUsers.any((u) => u.email == user.email)) {
      throw Exception("User already exists with this email");
    }

    final uuid = Uuid();
    final newUser = user.copyWith(userId: uuid.v4());
    allUsers.add(newUser);
    await _saveAllUsers(allUsers);
  }

  @override
  Future<UserModel?> getUserByEmailAndPassword(
    String email,
    String password,
  ) async {
    final allUsers = await _getAllUsers();
    try {
      return allUsers.firstWhere(
        (u) => u.email == email && u.password == password,
      );
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> updateUser(UserModel user) async {
    final allUsers = await _getAllUsers();
    final index = allUsers.indexWhere((u) => u.userId == user.userId);
    if (index != -1) {
      allUsers[index] = user;
      await _saveAllUsers(allUsers);
    }
  }

  @override
  Future<void> saveLoggedInUser(String? userId) async {
    if (userId == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(loggedInKey, userId);
  }

  @override
  Future<UserModel?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(loggedInKey);
    if (userId == null) return null;
    final allUsers = await _getAllUsers();
    try {
      return allUsers.firstWhere((u) => u.userId == userId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> userLogout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(loggedInKey);
  }

  @override
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(loggedInKey) != null;
  }

  @override
  Future<UserModel?> getUserByEmail(String email) async {
    final users = await _getAllUsers();
    try {
      return users.firstWhere((user) => user.email == email);
    } catch (e) {
      return null;
    }
  }
}
