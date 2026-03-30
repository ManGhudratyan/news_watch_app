// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  username: json['username'] as String,
  email: json['email'] as String,
  phoneNumber: json['phoneNumber'] as String?,
  password: json['password'] as String?,
  imagePath: json['imagePath'] as String?,
  lastName: json['lastName'] as String?,
  userId: json['userId'] as String?,
  firstName: json['firstName'] as String?,
  userCity: json['userCity'] as String?,
  radioType: $enumDecodeNullable(_$RadioTypeEnumMap, json['radioType']),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'username': instance.username,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'password': instance.password,
  'imagePath': instance.imagePath,
  'lastName': instance.lastName,
  'userId': instance.userId,
  'firstName': instance.firstName,
  'userCity': instance.userCity,
  'radioType': _$RadioTypeEnumMap[instance.radioType],
};

const _$RadioTypeEnumMap = {
  RadioType.mediaReporter: 'mediaReporter',
  RadioType.visitor: 'visitor',
};
