part of 'add_post_cubit.dart';

class AddPostState extends Equatable {
  final List<PostModel>? posts;
  final List<PostModel>? savedPosts;
  final List<PostModel>? likedPosts;
  final bool loading;

  const AddPostState({
    required this.posts,
    required this.savedPosts,
    required this.likedPosts,
    required this.loading,
  });

  AddPostState copyWith({
    List<PostModel>? posts,
    List<PostModel>? savedPosts,
    List<PostModel>? likedPosts,
    bool? loading,
  }) {
    return AddPostState(
      posts: posts ?? this.posts,
      savedPosts: savedPosts ?? this.savedPosts,
      likedPosts: likedPosts ?? this.likedPosts,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [posts, savedPosts, likedPosts, loading];
}
