import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/data/models/add_post/add_post_model.dart';
import 'package:news_watch_app/presentation/constants/assets.dart';
import 'package:news_watch_app/presentation/pages/auth/logic/user_bloc.dart';

class PostDetailsPage extends StatefulWidget {
  final AddPostModel post;

  const PostDetailsPage({super.key, required this.post});

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(Icons.bookmark_border_rounded),
          SizedBox(width: 8),
          Icon(Icons.download_sharp),
          SizedBox(width: 16),
        ],
      ),
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, userState) {},
        builder: (context, userState) {
          String username = 'Unknown User';
          String userImage = Assets.userImage;

          if (userState is UserLoaded) {
            username = userState.user.username;
            if (userState.user.imagePath != null &&
                userState.user.imagePath!.isNotEmpty) {
              userImage = userState.user.imagePath!;
            }
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: screenHeight / 3,
                  child: post.imagePath != null && post.imagePath!.isNotEmpty
                      ? (post.imagePath!.startsWith('assets/')
                            ? Image.asset(post.imagePath!, fit: BoxFit.cover)
                            : Image.file(
                                File(post.imagePath!),
                                fit: BoxFit.cover,
                              ))
                      : const SizedBox(),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.heading,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: (userImage.isNotEmpty)
                                    ? (userImage.startsWith('assets/')
                                          ? AssetImage(userImage)
                                          : FileImage(File(userImage))
                                                as ImageProvider)
                                    : AssetImage(Assets.userImage),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                username,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            '1 hour ago',
                            style: TextStyle(color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: const [
                              Icon(Icons.comment_outlined, size: 20),
                              SizedBox(width: 4),
                              Text('8 comments'),
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(Icons.favorite_border, size: 20),
                              SizedBox(width: 4),
                              Text('34 likes'),
                            ],
                          ),
                          Row(
                            children: const [
                              Icon(Icons.share, size: 20),
                              SizedBox(width: 4),
                              Text('Share'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        post.description,
                        style: const TextStyle(fontSize: 16),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
