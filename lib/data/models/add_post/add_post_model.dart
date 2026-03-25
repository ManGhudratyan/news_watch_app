import 'package:json_annotation/json_annotation.dart';
part 'add_post_model.g.dart';

@JsonSerializable()
class AddPostModel {
  final String heading;
  final String? tag;
  final String category;
  final String description;
  final String? videoLink;
  final String? imagePath;
  final String userId;
  final String? username;

  factory AddPostModel.fromJson(Map<String, dynamic> json) =>
      _$AddPostModelFromJson(json);

  AddPostModel({
    required this.heading,
    this.tag,
    required this.category,
    required this.description,
    this.videoLink,
    this.imagePath,
    required this.userId,
    this.username,
  });

  Map<String, dynamic> toJson() => _$AddPostModelToJson(this);
}
