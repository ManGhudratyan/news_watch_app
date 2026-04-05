part of 'add_post_cubit.dart';

class AddPostState extends Equatable {
  final List<PostModel>? posts;
  final List<PostModel>? savedPosts;
  final bool loading;
  const AddPostState({this.posts, this.loading = true, this.savedPosts});

  AddPostState copyWith({
    List<PostModel>? posts,
    bool? loading,
    List<PostModel>? savedPosts,
  }) {
    return AddPostState(
      posts: posts ?? this.posts,
      loading: loading ?? this.loading,
      savedPosts: savedPosts ?? this.savedPosts,
    );
  }

  @override
  List<Object?> get props => [posts, loading, savedPosts];
}
