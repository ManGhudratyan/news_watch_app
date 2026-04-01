// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
// import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
// import 'package:news_watch_app/data/models/add_post/add_post_model.dart';
// import 'package:news_watch_app/presentation/constants/assets.dart';
// import 'package:news_watch_app/presentation/constants/gaps.dart';
// import 'package:news_watch_app/presentation/widgets/youtube_player_widget.dart';

// class PostDetailsPage extends StatefulWidget {
//   final AddPostModel post;

//   const PostDetailsPage({super.key, required this.post});

//   @override
//   State<PostDetailsPage> createState() => _PostDetailsPageState();
// }

// class _PostDetailsPageState extends State<PostDetailsPage> {
//   ImageProvider _buildUserImage(String userImage) {
//     if (userImage.isEmpty) {
//       return AssetImage(Assets.userImage);
//     }

//     if (userImage.startsWith('http')) {
//       return NetworkImage(userImage);
//     }

//     if (userImage.startsWith('assets/')) {
//       return AssetImage(userImage);
//     }

//     return FileImage(File(userImage));
//   }

//   void _showFullScreenImage(String imagePath) {
//     final bool isAsset = imagePath.startsWith('assets/');

//     showDialog(
//       context: context,
//       barrierColor: Colors.black87,
//       builder: (context) {
//         return Dialog(
//           backgroundColor: Colors.transparent,
//           insetPadding: const EdgeInsets.all(12),
//           child: Stack(
//             children: [
//               Center(
//                 child: InteractiveViewer(
//                   minScale: 0.8,
//                   maxScale: 4.0,
//                   child: isAsset
//                       ? Image.asset(imagePath, fit: BoxFit.contain)
//                       : Image.file(File(imagePath), fit: BoxFit.contain),
//                 ),
//               ),
//               Positioned(
//                 top: 16,
//                 right: 16,
//                 child: CircleAvatar(
//                   backgroundColor: Colors.black54,
//                   child: IconButton(
//                     onPressed: () => Navigator.pop(context),
//                     icon: const Icon(Icons.close, color: Colors.white),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildTopMedia(AddPostModel post, double screenHeight) {
//     final hasVideo = post.videoUrl != null && post.videoUrl!.isNotEmpty;
//     final hasImage = post.imagePath != null && post.imagePath!.isNotEmpty;

//     if (hasVideo) {
//       return SizedBox(
//         width: double.infinity,
//         height: screenHeight / 3,
//         child: YoutubePlayerWidget(videoUrl: post.videoUrl!),
//       );
//     }

//     if (hasImage) {
//       final String imagePath = post.imagePath!;
//       final bool isAsset = imagePath.startsWith('assets/');

//       return GestureDetector(
//         onTap: () => _showFullScreenImage(imagePath),
//         child: SizedBox(
//           width: double.infinity,
//           height: screenHeight / 3,
//           child: isAsset
//               ? Image.asset(imagePath, fit: BoxFit.cover)
//               : Image.file(File(imagePath), fit: BoxFit.cover),
//         ),
//       );
//     }

//     return SizedBox(
//       width: double.infinity,
//       height: screenHeight / 3,
//       child: Container(
//         color: Colors.grey.shade300,
//         alignment: Alignment.center,
//         child: const Icon(Icons.image_not_supported, size: 50),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final post = widget.post;
//     final screenHeight = MediaQuery.of(context).size.height;

//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           Icon(Icons.bookmark_border_rounded),
//           SizedBox(width: Gaps.medium),
//           Icon(Icons.download_sharp),
//           SizedBox(width: Gaps.large),
//         ],
//       ),
//       body: BlocBuilder<AuthCubit, AuthState>(
//         builder: (context, authState) {
//           String username = post.username ?? 'Unknown User';
//           String userImage = Assets.userImage;

//           if (authState.user != null) {
//             username = post.username ?? authState.user!.username;

//             if (authState.user!.imagePath != null &&
//                 authState.user!.imagePath!.isNotEmpty) {
//               userImage = authState.user!.imagePath!;
//             }
//           }

//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 _buildTopMedia(post, screenHeight),
//                 SizedBox(height: Gaps.large),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: Gaps.large),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         post.heading ?? 'heading',
//                         style: const TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: Gaps.large),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               CircleAvatar(
//                                 radius: 25,
//                                 backgroundImage: _buildUserImage(userImage),
//                               ),
//                               SizedBox(width: Gaps.medium),
//                               Text(
//                                 username,
//                                 style: const TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                   fontSize: 14,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const Text(
//                             '1 hour ago',
//                             style: TextStyle(color: Colors.grey, fontSize: 12),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: Gaps.large),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             children: [
//                               Icon(Icons.comment_outlined, size: 20),
//                               SizedBox(width: Gaps.small),
//                               Text('8 comments'),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Icon(Icons.favorite_border, size: 20),
//                               SizedBox(width: Gaps.small),
//                               Text('34 likes'),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Icon(Icons.share, size: 20),
//                               SizedBox(width: Gaps.small),
//                               Text('Share'),
//                             ],
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: Gaps.large),
//                       Text(
//                         post.description ?? 'description',
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                       SizedBox(height: Gaps.larger),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
import 'package:news_watch_app/data/models/add_post/add_post_model.dart';
import 'package:news_watch_app/presentation/constants/assets.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/widgets/youtube_player_widget.dart';

class PostDetailsPage extends StatefulWidget {
  final AddPostModel post;

  const PostDetailsPage({super.key, required this.post});

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
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

    return Scaffold(
      appBar: AppBar(
        actions: const [
          Icon(Icons.bookmark_border_rounded),
          SizedBox(width: 12),
          Icon(Icons.download_sharp),
          SizedBox(width: 20),
        ],
      ),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, authState) {
          String username = post.username ?? 'Unknown User';
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
            mediaWidget = SizedBox(
              width: double.infinity,
              height: screenHeight / 3,
              child: YoutubePlayerWidget(videoUrl: post.videoUrl!),
            );
          } else if (hasImage) {
            final imagePath = post.imagePath!;
            final isAsset = imagePath.startsWith('assets/');

            mediaWidget = GestureDetector(
              onTap: () => _showFullScreenImage(imagePath),
              child: SizedBox(
                width: double.infinity,
                height: screenHeight / 3,
                child: isAsset
                    ? Image.asset(imagePath, fit: BoxFit.cover)
                    : Image.file(File(imagePath), fit: BoxFit.cover),
              ),
            );
          } else {
            mediaWidget = SizedBox(
              width: double.infinity,
              height: screenHeight / 3,
              child: Container(
                color: Colors.grey.shade300,
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported, size: 50),
              ),
            );
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mediaWidget,
                SizedBox(height: Gaps.large),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Gaps.large),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.heading ?? 'heading',
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: Gaps.large),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25,
                                backgroundImage: userImageProvider,
                              ),
                              SizedBox(width: Gaps.medium),
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
                      SizedBox(height: Gaps.large),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.comment_outlined, size: 20),
                              SizedBox(width: Gaps.small),
                              Text('8 comments'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.favorite_border, size: 20),
                              SizedBox(width: Gaps.small),
                              Text('34 likes'),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.share, size: 20),
                              SizedBox(width: Gaps.small),
                              Text('Share'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: Gaps.large),
                      Text(
                        post.description ?? 'description',
                        style: const TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: Gaps.larger),
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
