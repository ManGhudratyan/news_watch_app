import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/core/utils/video_utils.dart';
import 'package:news_watch_app/cubits/add_post/cubit/add_post_cubit.dart';
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
    final text = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(text.txtSavedPosts),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          final currentUsername = authState.user?.username ?? text.txtUsername;
          final userImage = authState.user?.imagePath?.isNotEmpty == true
              ? authState.user!.imagePath!
              : Assets.userImage;

          return BlocBuilder<AddPostCubit, AddPostState>(
            builder: (context, state) {
              final savedPosts = state.savedPosts ?? [];

              if (savedPosts.isEmpty) {
                return Center(child: Text(text.txtNoSavedPosts));
              }

              return ListView.builder(
                itemCount: savedPosts.length,
                itemBuilder: (context, index) {
                  final post = savedPosts[index];
                  final hasLocalImage =
                      post.imagePath != null && post.imagePath!.isNotEmpty;

                  final imageToShow = hasLocalImage
                      ? post.imagePath!
                      : (VideoUtils.getYoutubeThumbnail(post.videoUrl) ??
                            Assets.postImage);

                  return GestureDetector(
                    onTap: () {
                      // Navigator.of(context).pushNamed(
                      //   RouteConstants.postDetailsPage,
                      //   arguments: post,
                      // );
                      context.push(RouteConstants.postDetailsPage, extra: post);
                    },
                    child: PostWidget(
                      post: post,
                      image: imageToShow,
                      postName: post.heading ?? text.txtHeading,
                      username: post.username ?? currentUsername,
                      userImage: userImage,
                      description: post.description ?? text.txtDescription,
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
