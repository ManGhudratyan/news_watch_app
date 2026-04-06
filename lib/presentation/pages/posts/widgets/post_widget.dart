// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/cubits/add_post/cubit/add_post_cubit.dart';
import 'package:news_watch_app/data/models/post/post_model.dart';
import 'package:news_watch_app/presentation/constants/assets.dart';
import 'package:news_watch_app/presentation/constants/constants.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.post,
    required this.image,
    required this.postName,
    required this.userImage,
    required this.username,
    required this.description,
    this.isSponsored = false,
    this.isVideo = false,
    this.isLocalImage = false,
  });

  final PostModel post;
  final String image;
  final String postName;
  final String userImage;
  final String username;
  final String description;
  final bool isSponsored;
  final bool isVideo;
  final bool isLocalImage;

  @override
  Widget build(BuildContext context) {
    ImageProvider userImg = userImage.startsWith('http')
        ? NetworkImage(userImage)
        : userImage.startsWith('assets/')
        ? AssetImage(userImage)
        : FileImage(File(userImage));

    Widget postImg = image.isEmpty
        ? Image.asset(
            Assets.postImage,
            width: double.infinity,
            height: Constants.postHeight,
            fit: BoxFit.cover,
          )
        : isLocalImage
        ? Image.file(
            File(image),
            width: double.infinity,
            height: Constants.postHeight,
            fit: BoxFit.cover,
          )
        : image.startsWith('assets/')
        ? Image.asset(
            image,
            width: double.infinity,
            height: Constants.postHeight,
            fit: BoxFit.cover,
          )
        : Image.network(
            image,
            width: double.infinity,
            height: Constants.postHeight,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stacktrace) {
              return Image.asset(
                Assets.postImage,
                width: double.infinity,
                height: Constants.postHeight,
                fit: BoxFit.cover,
              );
            },
          );

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Gaps.large,
        vertical: Gaps.large,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.borderRadiusCircular),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(Constants.borderRadiusCircular),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                postImg,
                if (isVideo)
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.45),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(Gaps.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        postName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    PopupMenuButton<String>(
                      onSelected: (value) async {
                        if (value == 'delete') {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Delete Post'),
                                content: const Text(
                                  'Are you sure you want to delete this post?',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);
                                    },
                                    child: const Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );

                          if (confirm == true) {
                            await context.read<AddPostCubit>().deletePost(post);

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Post deleted')),
                              );
                            }
                          }
                        }
                      },
                      itemBuilder: (context) => const [
                        PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Delete'),
                            ],
                          ),
                        ),
                      ],
                      child: const Padding(
                        padding: EdgeInsets.all(4),
                        child: Icon(Icons.more_vert),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Constants.sizedBoxSize),
                Row(
                  children: [
                    CircleAvatar(radius: 25, backgroundImage: userImg),
                    SizedBox(width: Constants.sizedBoxSize),
                    Text(
                      username,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Constants.sizedBoxSize),
                Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey.shade800, fontSize: 14),
                ),
                SizedBox(height: Constants.sizedBoxSize),
                Row(
                  children: [
                    BlocBuilder<AddPostCubit, AddPostState>(
                      builder: (context, state) {
                        final isLiked = (state.likedPosts ?? []).any(
                          (item) =>
                              item.heading == post.heading &&
                              item.description == post.description &&
                              item.postCreated == post.postCreated,
                        );

                        return GestureDetector(
                          onTap: () async {
                            await context.read<AddPostCubit>().toggleLikePost(
                              post,
                            );
                          },
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            color: isLiked ? Colors.red : Colors.black,
                          ),
                        );
                      },
                    ),
                    SizedBox(width: Constants.sizedBoxSize),
                    BlocBuilder<AddPostCubit, AddPostState>(
                      builder: (context, state) {
                        final isSaved = (state.savedPosts ?? []).any(
                          (item) =>
                              item.heading == post.heading &&
                              item.description == post.description &&
                              item.postCreated == post.postCreated,
                        );

                        return GestureDetector(
                          onTap: () async {
                            await context.read<AddPostCubit>().toggleSavedPost(
                              post,
                            );
                          },
                          child: Icon(
                            isSaved
                                ? Icons.bookmark_rounded
                                : Icons.bookmark_border_rounded,
                            color: isSaved ? Colors.indigo : Colors.black,
                          ),
                        );
                      },
                    ),
                    SizedBox(width: Constants.sizedBoxSize),
                    GestureDetector(
                      onTap: () {
                        context.read<AddPostCubit>().sharePost(post);
                      },
                      child: const Icon(Icons.share_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
