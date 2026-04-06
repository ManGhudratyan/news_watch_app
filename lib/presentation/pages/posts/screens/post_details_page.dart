// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/core/utils/date_utils.dart';
import 'package:news_watch_app/cubits/add_post/cubit/add_post_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
import 'package:news_watch_app/data/models/post/post_model.dart';
import 'package:news_watch_app/presentation/constants/assets.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/widgets/youtube_player_widget.dart';

class PostDetailsPage extends StatefulWidget {
  final PostModel post;

  const PostDetailsPage({super.key, required this.post});

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  void _showFullScreenVideo(String videoUrl) {
    showDialog(
      context: context,
      barrierColor: Colors.black,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Stack(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: YoutubePlayerWidget(videoUrl: videoUrl),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showFullScreenImage(String imagePath) {
    final bool isAsset = imagePath.startsWith('assets/');

    showDialog(
      context: context,
      barrierColor: Colors.black87,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(12),
          child: Stack(
            children: [
              Center(
                child: InteractiveViewer(
                  minScale: 0.8,
                  maxScale: 4.0,
                  child: isAsset
                      ? Image.asset(imagePath)
                      : Image.file(File(imagePath)),
                ),
              ),
              Positioned(
                top: Gaps.large,
                right: Gaps.large,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    final screenHeight = MediaQuery.of(context).size.height;
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          String username = post.username ?? text.txtUsername;
          String userImage = Assets.userImage;
          ImageProvider userImageProvider;
          Widget mediaWidget;

          if (authState.user != null) {
            username = post.username ?? authState.user!.username;

            if (authState.user!.imagePath != null &&
                authState.user!.imagePath!.isNotEmpty) {
              userImage = authState.user!.imagePath!;
            }
          }

          if (userImage.isEmpty) {
            userImageProvider = AssetImage(Assets.userImage);
          } else if (userImage.startsWith('http')) {
            userImageProvider = NetworkImage(userImage);
          } else if (userImage.startsWith('assets/')) {
            userImageProvider = AssetImage(userImage);
          } else {
            userImageProvider = FileImage(File(userImage));
          }

          final hasVideo = post.videoUrl != null && post.videoUrl!.isNotEmpty;
          final hasImage = post.imagePath != null && post.imagePath!.isNotEmpty;

          if (hasVideo) {
            mediaWidget = GestureDetector(
              onTap: () => _showFullScreenVideo(post.videoUrl!),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.33,
                    child: YoutubePlayerWidget(videoUrl: post.videoUrl!),
                  ),
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.45),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.fullscreen,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                ],
              ),
            );
          } else if (hasImage) {
            final imagePath = post.imagePath!;
            final isAsset = imagePath.startsWith('assets/');

            mediaWidget = GestureDetector(
              onTap: () => _showFullScreenImage(imagePath),
              child: SizedBox(
                width: double.infinity,
                height: screenHeight * 0.33,
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(26),
                  ),
                  child: isAsset
                      ? Image.asset(imagePath, fit: BoxFit.cover)
                      : Image.file(File(imagePath), fit: BoxFit.cover),
                ),
              ),
            );
          } else {
            mediaWidget = Container(
              width: double.infinity,
              height: screenHeight * 0.33,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(26),
                ),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.image_not_supported, size: 50),
            );
          }

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    mediaWidget,
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(
                        Gaps.large,
                        Gaps.large,
                        Gaps.large,
                        Gaps.larger,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFF6F7FB),
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Gaps.medium),
                          Text(
                            post.heading ?? text.txtHeading,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: Gaps.large),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: userImageProvider,
                                    ),
                                    SizedBox(width: Gaps.medium),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          username,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15,
                                          ),
                                        ),
                                        SizedBox(height: Gaps.small),
                                        Text(
                                          DateUtilsHelper.formatPostTime(
                                            post.postCreated,
                                          ),
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Gaps.large),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                BlocBuilder<AddPostCubit, AddPostState>(
                                  builder: (context, state) {
                                    final isSaved = (state.savedPosts ?? [])
                                        .any(
                                          (item) =>
                                              item.heading == post.heading &&
                                              item.description ==
                                                  post.description &&
                                              item.postCreated ==
                                                  post.postCreated,
                                        );

                                    return InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () async {
                                        await context
                                            .read<AddPostCubit>()
                                            .toggleSavedPost(post);
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            isSaved
                                                ? Icons.bookmark_rounded
                                                : Icons.bookmark_border_rounded,
                                            size: 20,
                                            color: isSaved
                                                ? Colors.indigo
                                                : Colors.black87,
                                          ),
                                          SizedBox(width: Gaps.small),
                                          Text(
                                            isSaved ? 'Saved' : 'Save',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                BlocBuilder<AddPostCubit, AddPostState>(
                                  builder: (context, state) {
                                    final isLiked = (state.likedPosts ?? [])
                                        .any(
                                          (item) =>
                                              item.heading == post.heading &&
                                              item.description ==
                                                  post.description &&
                                              item.postCreated ==
                                                  post.postCreated,
                                        );

                                    return InkWell(
                                      borderRadius: BorderRadius.circular(12),
                                      onTap: () async {
                                        await context
                                            .read<AddPostCubit>()
                                            .toggleLikePost(post);
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            isLiked
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            size: 20,
                                            color: isLiked
                                                ? Colors.red
                                                : Colors.black87,
                                          ),
                                          SizedBox(width: Gaps.small),
                                          Text(
                                            isLiked ? 'Liked' : 'Like',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: isLiked
                                                  ? Colors.red
                                                  : Colors.black87,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    context.read<AddPostCubit>().sharePost(
                                      post,
                                    );
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(Icons.share, size: 20),
                                      SizedBox(width: Gaps.small),
                                       Text(
                                        text.txtShare,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Gaps.large),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Text(
                              post.description ?? text.txtDescription,
                              style: const TextStyle(
                                fontSize: 16,
                                height: 1.5,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
