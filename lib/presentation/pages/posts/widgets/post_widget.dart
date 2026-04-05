// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/cubits/add_post/cubit/add_post_cubit.dart';
import 'package:news_watch_app/presentation/constants/assets.dart';
import 'package:news_watch_app/presentation/constants/constants.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';

class PostWidget extends StatelessWidget {
  const PostWidget({
    super.key,
    required this.image,
    required this.postName,
    required this.userImage,
    required this.username,
    required this.description,
    this.isSponsored = false,
    this.commentsCount = 0,
    this.viewsCount = 0,
    this.isVideo = false,
    this.isLocalImage = false,
  });

  final String image;
  final String postName;
  final String userImage;
  final String username;
  final String description;
  final bool isSponsored;
  final int commentsCount;
  final int viewsCount;
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
                    const Icon(Icons.more_vert),
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
                Column(
                  children: [
                    Row(
                      children: [
                        BlocBuilder<AddPostCubit, AddPostState>(
                          builder: (context, state) {
                            final isLiked = (state.likedPosts ?? []).any(
                              (item) =>
                                  item.heading == postName &&
                                  item.description == description,
                            );

                            return GestureDetector(
                              onTap: () {},
                              child: Icon(
                                isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: isLiked ? Colors.red : Colors.black,
                              ),
                            );
                          },
                        ),
                        SizedBox(width: Constants.sizedBoxSize),
                        const Icon(Icons.chat_bubble_outline),
                        SizedBox(width: Constants.sizedBoxSize),
                        const Icon(Icons.share_outlined),
                      ],
                    ),
                    SizedBox(height: Constants.sizedBoxSize),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Text(
                          "$commentsCount comments . $viewsCount views",
                          style: TextStyle(
                            color: Colors.grey.shade600,
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
        ],
      ),
    );
  }
}
