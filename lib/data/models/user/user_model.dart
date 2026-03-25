import 'package:json_annotation/json_annotation.dart';
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
  });

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
