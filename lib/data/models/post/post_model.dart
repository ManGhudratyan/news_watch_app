import 'package:json_annotation/json_annotation.dart';
part 'post_model.g.dart';

@JsonSerializable()
class PostModel {
  final String? heading;
  final String? tag;
  final String? category;
  final String? description;
  final String? videoLink;
  final String? imagePath;
  final String userId;
  final String? username;
  final String? videoUrl;
  final String? userLike;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  PostModel({
    this.heading,
    this.tag,
    this.category,
    this.description,
    this.videoLink,
    this.imagePath,
    required this.userId,
    this.username,
    this.videoUrl,
    this.userLike,
  });

  Map<String, dynamic> toJson() => _$PostModelToJson(this);
}
