part of 'add_post_cubit.dart';

class AddPostState extends Equatable {
  final List<PostModel>? posts;
  final bool loading;
  const AddPostState({this.posts, this.loading = true});

  AddPostState copyWith({List<PostModel>? posts, bool? loading}) {
    return AddPostState(
      posts: posts ?? this.posts,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [posts, loading];
}
