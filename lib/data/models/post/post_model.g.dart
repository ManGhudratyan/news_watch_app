// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostModel _$PostModelFromJson(Map<String, dynamic> json) => PostModel(
  heading: json['heading'] as String?,
  tag: json['tag'] as String?,
  category: json['category'] as String?,
  description: json['description'] as String?,
  videoLink: json['videoLink'] as String?,
  imagePath: json['imagePath'] as String?,
  userId: json['userId'] as String,
  username: json['username'] as String?,
  videoUrl: json['videoUrl'] as String?,
  userLike: json['userLike'] as String?,
  postCreated: json['postCreated'] == null
      ? null
      : DateTime.parse(json['postCreated'] as String),
  id: json['id'] as String?,
);

Map<String, dynamic> _$PostModelToJson(PostModel instance) => <String, dynamic>{
  'id': instance.id,
  'heading': instance.heading,
  'tag': instance.tag,
  'category': instance.category,
  'description': instance.description,
  'videoLink': instance.videoLink,
  'imagePath': instance.imagePath,
  'userId': instance.userId,
  'username': instance.username,
  'videoUrl': instance.videoUrl,
  'userLike': instance.userLike,
  'postCreated': instance.postCreated?.toIso8601String(),
};
