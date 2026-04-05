import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/cubits/add_post/cubit/add_post_cubit.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
import 'package:news_watch_app/presentation/constants/assets.dart';
import 'package:news_watch_app/presentation/pages/posts/widgets/post_widget.dart';

class SavedPostsPage extends StatefulWidget {
  const SavedPostsPage({super.key});

  @override
  State<SavedPostsPage> createState() => _SavedPostsPageState();
}

class _SavedPostsPageState extends State<SavedPostsPage> {
  @override
  void initState() {
    super.initState();

    final userId = context.read<AuthCubit>().state.user?.userId;
    if (userId != null && userId.isNotEmpty) {
      context.read<AddPostCubit>().getSavedPosts(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Posts'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          final currentUsername = authState.user?.username ?? 'username';

          return BlocBuilder<AddPostCubit, AddPostState>(
            builder: (context, state) {
              final savedPosts = state.savedPosts ?? [];

              if (savedPosts.isEmpty) {
                return const Center(child: Text('No saved posts yet'));
              }

              return ListView.builder(
                itemCount: savedPosts.length,
                itemBuilder: (context, index) {
                  final post = savedPosts[index];
                  final hasLocalImage =
                      post.imagePath != null && post.imagePath!.isNotEmpty;

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        RouteConstants.postDetailsPage,
                        arguments: post,
                      );
                    },
                    child: PostWidget(
                      image: hasLocalImage ? post.imagePath! : Assets.postImage,
                      postName: post.heading ?? 'heading',
                      username: post.username ?? currentUsername,
                      userImage: Assets.userImage,
                      description: post.description ?? 'description',
                      isLocalImage: hasLocalImage,
                      isVideo:
                          post.videoUrl != null && post.videoUrl!.isNotEmpty,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
