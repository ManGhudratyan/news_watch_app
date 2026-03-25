part of 'add_post_bloc.dart';

@immutable
sealed class AddPostEvent {}

final class AddNewPostEvent extends AddPostEvent {
  final AddPostModel model;
  AddNewPostEvent(this.model);
}

final class GetPostsEvent extends AddPostEvent {
  final String userId;
  GetPostsEvent({required this.userId});
}
