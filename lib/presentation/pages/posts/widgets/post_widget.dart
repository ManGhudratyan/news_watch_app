// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
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
  });

  final String image;
  final String postName;
  final String userImage;
  final String username;
  final String description;

  final bool isSponsored;
  final int commentsCount;
  final int viewsCount;

  @override
  Widget build(BuildContext context) {
    final txt = AppLocalizations.of(context);

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
            child: _buildPostImage(image),
          ),
          Padding(
            padding: EdgeInsets.all(Gaps.large),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
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
                    SizedBox(width: Gaps.medium),
                    const Icon(Icons.more_vert),
                  ],
                ),
                SizedBox(height: Constants.sizedBoxSize),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: userImage.startsWith('assets/')
                          ? AssetImage(userImage)
                          : FileImage(File(userImage)) as ImageProvider,
                    ),
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
                        const Icon(Icons.favorite_border),
                        SizedBox(width: Constants.sizedBoxSize),
                        const Icon(Icons.chat_bubble_outline),
                        SizedBox(width: Constants.sizedBoxSize),
                        const Icon(Icons.share_outlined),
                        SizedBox(width: Constants.sizedBoxSize),
                        if (isSponsored)
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Icon(Icons.campaign, color: Colors.pink),
                              SizedBox(width: Gaps.small),
                              Text(
                                txt!.txtSponsored,
                                style: const TextStyle(color: Colors.pink),
                              ),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(height: Constants.sizedBoxSize),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(),
                        Text(
                          "$commentsCount comments · $viewsCount views",
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

  Widget _buildPostImage(String imagePath) {
    if (imagePath.isEmpty) {
      return Image.asset(
        Assets.postImage,
        width: double.infinity,
        height: Constants.postHeight,
        fit: BoxFit.cover,
      );
    } else if (imagePath.startsWith('assets/')) {
      return Image.asset(
        imagePath,
        width: double.infinity,
        height: Constants.postHeight,
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(imagePath),
        width: double.infinity,
        height: Constants.postHeight,
        fit: BoxFit.cover,
      );
    }
  }
}
