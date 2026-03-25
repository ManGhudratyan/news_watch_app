// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/presentation/constants/assets.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/pages/auth/logic/user_bloc.dart';
import 'package:news_watch_app/presentation/pages/posts/logic/add_post_bloc.dart';
import 'package:news_watch_app/presentation/pages/posts/widgets/post_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userState = context.read<UserBloc>().state;
      if (userState is UserLoaded) {
        context.read<AddPostBloc>().add(
          GetPostsEvent(userId: userState.user.userId ?? ''),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: Row(
          children: const [
            Icon(Icons.location_on, color: Colors.red),
            SizedBox(width: 8),
            Text('G.T.Road, Kolkata', style: TextStyle(fontSize: 16)),
          ],
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Gaps.small,
              vertical: Gaps.small,
            ),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(17),
              color: Colors.white.withOpacity(0.2),
            ),
            child: Row(
              children: [
                Icon(Icons.stars_sharp, color: Colors.yellow),
                SizedBox(width: Gaps.small),
                Text('599', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.blueAccent),
            onPressed: () {},
          ),
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, userState) {
          String currentUsername = 'Unknown User';
          String userImage = Assets.userImage;
          if (userState is UserLoaded) {
            currentUsername = userState.user.username;
            if (userState.user.imagePath != null &&
                userState.user.imagePath!.isNotEmpty) {
              userImage = userState.user.imagePath!;
            }
          }

          return BlocBuilder<AddPostBloc, AddPostState>(
            builder: (context, state) {
              if (state is AddPostLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AddPostLoaded) {
                final posts = state.posts;
                if (posts.isEmpty) {
                  return const Center(child: Text("You haven't posted yet"));
                }
                return ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context, rootNavigator: true).pushNamed(
                          RouteConstants.postDetailsPage,
                          arguments: post,
                        );
                      },
                      child: PostWidget(
                        image: post.imagePath ?? Assets.postImage,
                        postName: post.heading,
                        username: post.username ?? currentUsername,
                        userImage: userImage,
                        description: post.description,
                      ),
                    );
                  },
                );
              } else if (state is AddPostFailure) {
                return Center(child: Text('Error: ${state.error}'));
              }
              return const Center(child: Text("No posts yet"));
            },
          );
        },
      ),
    );
  }
}
