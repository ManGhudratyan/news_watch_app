// ignore_for_file: unrelated_type_equality_checks, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:news_watch_app/core/extensions/scaffold_extension.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/cubits/add_post/cubit/add_post_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/pages/posts/widgets/post_elements_widget.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  final TextEditingController headingController = TextEditingController();
  final TextEditingController videoController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    headingController.dispose();
    videoController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final txt = AppLocalizations.of(context)!;
    return BlocListener<AddPostCubit, AddPostState>(
      listener: (context, state) {
        if (state.posts == true) {
          // Navigator.of(
          //   context,
          //   rootNavigator: true,
          // ).pushNamed(RouteConstants.mainPage);
          context.push(RouteConstants.mainPage);
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
            backgroundColor: const Color(0xFFF4F7FB),
            appBar: AppBar(title: const Text("")),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(Gaps.large),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(22),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(219, 165, 129, 123),
                          Color(0xFF6C63FF),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.18),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.video_collection_rounded,
                          color: Colors.white,
                          size: 34,
                        ),
                        SizedBox(height: 14),
                        Text(
                          txt.txtCreateVideoPost,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Gaps.large),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(26),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentGeometry.center,
                          child: Text(
                            txt.txtPostDetails,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        SizedBox(height: Gaps.large),
                        PostElementsWidget(
                          title: txt.txtAddHeading,
                          controller: headingController,
                        ),
                        SizedBox(height: Gaps.large),
                        PostElementsWidget(
                          title: txt.txtVideoLink,
                          controller: videoController,
                        ),
                        SizedBox(height: Gaps.medium),
                        Text(
                          txt.txtExample,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: Gaps.large),
                        PostElementsWidget(
                          title: txt.txtDescription,
                          controller: descriptionController,
                        ),
                        SizedBox(height: Gaps.larger),
                        BlocBuilder<AddPostCubit, AddPostState>(
                          builder: (context, addPostState) {
                            final isLoading = addPostState.loading;

                            return SizedBox(
                              width: double.infinity,
                              height: 54,
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF3B82F6),
                                      Color(0xFF6366F1),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.withOpacity(0.22),
                                      blurRadius: 14,
                                      offset: const Offset(0, 8),
                                    ),
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: isLoading
                                      ? null
                                      : () async {
                                          final message = await context
                                              .read<AddPostCubit>()
                                              .submitVideoPost(
                                                heading: headingController.text,
                                                description:
                                                    descriptionController.text,
                                                userId: currentUserId!,
                                                username: currentUsername,
                                                videoUrl: videoController.text,
                                              );

                                          if (!context.mounted) return;

                                          if (message != null) {
                                            context.showSnackBarMessage(
                                              message,
                                            );
                                            return;
                                          }

                                          // Navigator.of(
                                          //   context,
                                          //   rootNavigator: true,
                                          // ).pushNamed(RouteConstants.mainPage);
                                          context.push(RouteConstants.mainPage);
                                        },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18),
                                    ),
                                  ),
                                  child: isLoading
                                      ? const SizedBox(
                                          height: 22,
                                          width: 22,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2.2,
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.publish_rounded,
                                              color: Colors.white,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              txt.txtPostVideo,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
