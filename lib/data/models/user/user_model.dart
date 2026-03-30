import 'package:json_annotation/json_annotation.dart';
import 'package:news_watch_app/core/enums/radio_type.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String username;
  final String email;
  final String? phoneNumber;
  final String? password;
  final String? imagePath;
  final String? lastName;
  final String? userId;
  final String? firstName;
  final String? userCity;
  final RadioType? radioType;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  UserModel({
    required this.username,
    required this.email,
    this.phoneNumber,
    this.password,
    this.imagePath,
    this.lastName,
    this.userId,
    this.firstName,
    this.userCity,
    this.radioType,
  });

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
  UserModel copyWith({
    String? username,
    String? email,
    String? phoneNumber,
    String? password,
    String? userId,
    String? userCity,
    RadioType? radioType,
  }) {
    return UserModel(
      username: username ?? this.username,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      password: password ?? this.password,
      userId: userId ?? this.userId,
      userCity: userCity ?? this.userCity,
      radioType: radioType ?? this.radioType,
    );
  }
}
