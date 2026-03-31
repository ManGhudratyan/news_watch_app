import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/cubits/add_post/cubit/add_post_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
import 'package:news_watch_app/data/models/add_post/add_post_model.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/pages/posts/widgets/post_elements_widget.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';

class AddVideoPage extends StatefulWidget {
  const AddVideoPage({super.key});

  @override
  State<AddVideoPage> createState() => _AddVideoPageState();
}

class _AddVideoPageState extends State<AddVideoPage> {
  final TextEditingController headingController = TextEditingController();
  final TextEditingController videoController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  bool isYoutubeUrl(String url) {
    return url.contains('youtube.com/watch?v=') || url.contains('youtu.be/');
  }

  void _submitPost(BuildContext context, String userId, String? username) {
    final videoUrl = videoController.text.trim();

    if (headingController.text.isEmpty || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill heading and description fields'),
        ),
      );
      return;
    }

    if (videoUrl.isNotEmpty && !isYoutubeUrl(videoUrl)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid YouTube link')),
      );
      return;
    }

    final model = AddPostModel(
      heading: headingController.text.trim(),
      description: descriptionController.text.trim(),
      videoUrl: videoUrl.isEmpty ? null : videoUrl,
      userId: userId,
      username: username,
    );

    final addPostCubit = context.read<AddPostCubit>();
    addPostCubit.addNewPost(model);
    addPostCubit.getPosts(userId);

    Navigator.of(
      context,
      rootNavigator: true,
    ).pushNamed(RouteConstants.mainPage);
  }

  @override
  void dispose() {
    headingController.dispose();
    videoController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddPostCubit, AddPostState>(
      listener: (context, state) {
        if (state.posts == true) {
          Navigator.of(
            context,
            rootNavigator: true,
          ).pushNamed(RouteConstants.mainPage);
        }
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          if (authState.user == null) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final currentUserId = authState.user?.userId;
          final currentUsername = authState.user?.username;

          return Scaffold(
            appBar: AppBar(title: const Text("Add Video"), centerTitle: true),
            body: Padding(
              padding: EdgeInsets.all(Gaps.large),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Gaps.large),
                    PostElementsWidget(
                      title: 'Heading',
                      controller: headingController,
                    ),
                    SizedBox(height: Gaps.large),
                    PostElementsWidget(
                      title: 'YouTube Video Link',
                      controller: videoController,
                    ),
                    SizedBox(height: Gaps.large),
                    PostElementsWidget(
                      title: 'Description',
                      controller: descriptionController,
                    ),
                    SizedBox(height: Gaps.larger),
                    BlocBuilder<AddPostCubit, AddPostState>(
                      builder: (context, addPostState) {
                        final isLoading = addPostState.loading;
                        return Center(
                          child: ElevatedButton(
                            onPressed: isLoading
                                ? null
                                : () => _submitPost(
                                    context,
                                    currentUserId!,
                                    currentUsername,
                                  ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.lightBlueAccent,
                            ),
                            child: isLoading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'Post',
                                    style: TextStyle(color: Colors.white),
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
