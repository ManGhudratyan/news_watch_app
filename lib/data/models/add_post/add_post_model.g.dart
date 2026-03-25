// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPostModel _$AddPostModelFromJson(Map<String, dynamic> json) => AddPostModel(
  heading: json['heading'] as String,
  tag: json['tag'] as String?,
  category: json['category'] as String,
  description: json['description'] as String,
  videoLink: json['videoLink'] as String?,
  imagePath: json['imagePath'] as String?,
  userId: json['userId'] as String,
  username: json['username'] as String?,
);

Map<String, dynamic> _$AddPostModelToJson(AddPostModel instance) =>
    <String, dynamic>{
      'heading': instance.heading,
      'tag': instance.tag,
      'category': instance.category,
      'description': instance.description,
      'videoLink': instance.videoLink,
      'imagePath': instance.imagePath,
      'userId': instance.userId,
      'username': instance.username,
    };
