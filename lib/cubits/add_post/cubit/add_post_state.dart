part of 'add_post_cubit.dart';

@immutable
sealed class AddPostState {}

final class AddPostInitial extends AddPostState {}

class AddPostLoading extends AddPostState {}

class AddPostLoaded extends AddPostState {
  final List<AddPostModel> posts;
  AddPostLoaded(this.posts);
}

class AddPostFailure extends AddPostState {
  final String error;
  AddPostFailure(this.error);
}

class AddPostSuccess extends AddPostState {}
