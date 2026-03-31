import 'package:json_annotation/json_annotation.dart';
part 'add_post_model.g.dart';

@JsonSerializable()
class AddPostModel {
  final String? heading;
  final String? tag;
  final String? category;
  final String? description;
  final String? videoLink;
  final String? imagePath;
  final String userId;
  final String? username;
  final String? videoUrl;

  factory AddPostModel.fromJson(Map<String, dynamic> json) =>
      _$AddPostModelFromJson(json);

  AddPostModel({
    this.heading,
    this.tag,
    this.category,
    this.description,
    this.videoLink,
    this.imagePath,
    required this.userId,
    this.username,
    this.videoUrl,
  });

  Map<String, dynamic> toJson() => _$AddPostModelToJson(this);
}
