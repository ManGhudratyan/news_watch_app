// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:news_watch_app/core/l10n/app_localizations.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/core/utils/video_utils.dart';
import 'package:news_watch_app/cubits/add_post/cubit/add_post_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
import 'package:news_watch_app/presentation/constants/assets.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/pages/posts/widgets/post_widget.dart';
import 'package:news_watch_app/presentation/widgets/slider_widget.dart';
import 'package:tabbed_sliverlist/tabbed_sliverlist.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = context.read<AuthCubit>().state.user?.userId;

      if (userId != null && userId.isNotEmpty) {
        final addPostCubit = context.read<AddPostCubit>();
        addPostCubit.getPosts(userId);
        addPostCubit.getSavedPosts(userId);
        addPostCubit.getLikedPosts(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;
    final List<String> tabs = [
      'All',
      'Popular',
      'Politics',
      'Tech',
      'Healthy',
      'Science',
    ];

    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, authState) {
        if (authState.user == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final currentUsername = authState.user?.username;
        final userImage = authState.user?.imagePath?.isNotEmpty == true
            ? authState.user!.imagePath!
            : Assets.userImage;

        return SliderDrawer(
          key: _sliderDrawerKey,
          sliderOpenSize: 250,
          isDraggable: true,
          appBar: const SizedBox.shrink(),
          slider: Container(
            color: Colors.white,
            child: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 16,
                ),
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.grey.shade200,
                        backgroundImage:
                            authState.user?.imagePath?.isNotEmpty == true
                            ? FileImage(File(authState.user!.imagePath!))
                            : AssetImage(Assets.userImage) as ImageProvider,
                      ),
                      SizedBox(height: Gaps.large),
                      Text(
                        authState.user!.username,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: Gaps.medium),
                      Text(
                        authState.user?.userCity ?? 'User city',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Gaps.larger),
                  Divider(color: Colors.grey.shade300),
                  SliderWidget(
                    icon: Icons.location_on_outlined,
                    title: 'Change city',
                    onTap: () {
                      context.push(RouteConstants.cityPage);
                    },
                  ),
                  SliderWidget(
                    icon: Icons.verified_user_outlined,
                    title: 'About page',
                    onTap: () {
                      context.push(RouteConstants.aboutPage);
                    },
                  ),
                  SliderWidget(
                    icon: Icons.password_sharp,
                    title: text.txtForgotPassword,
                    onTap: () {
                      context.push(RouteConstants.forgotPasswordPage);
                    },
                  ),
                  SliderWidget(
                    icon: Icons.bookmark_border_rounded,
                    title: text.txtSavedPosts,
                    onTap: () {
                      context.push(RouteConstants.savedPostsPage);
                    },
                  ),
                  Divider(color: Colors.grey.shade300),
                  SizedBox(height: Gaps.medium),
                  SliderWidget(
                    icon: Icons.logout,
                    title: text.txtLogOut,
                    isLogout: true,
                    onTap: () {
                      context.read<AuthCubit>().userlogOut();
                    },
                  ),
                ],
              ),
            ),
          ),
          child: Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.menu),
                          onPressed: () {
                            _sliderDrawerKey.currentState?.toggle();
                          },
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              context.push(RouteConstants.cityPage);
                            },
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                ),
                                SizedBox(width: Gaps.medium),
                                Expanded(
                                  child: Text(
                                    authState.user?.userCity?.isNotEmpty == true
                                        ? authState.user!.userCity!
                                        : 'Select your city...',
                                    style: const TextStyle(fontSize: 16),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                            children: const [
                              Icon(Icons.stars_sharp, color: Colors.yellow),
                              SizedBox(width: 4),
                              Text(
                                '599',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            color: Colors.blueAccent,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<AddPostCubit, AddPostState>(
                      builder: (context, addPostState) {
                        if (addPostState.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final posts = addPostState.posts ?? [];

                        return TabbedList(
                          tabLength: tabs.length,
                          sliverTabBar: SliverTabBar(
                            title: const SizedBox.shrink(),
                            expandedHeight: kToolbarHeight,
                            tabBar: TabBar(
                              isScrollable: true,
                              labelPadding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              tabs: tabs.map((tab) => Tab(text: tab)).toList(),
                            ),
                          ),
                          tabLists: tabs.map((tab) {
                            final filteredPosts = tab == 'All'
                                ? posts
                                : posts.where((post) {
                                    return (post.category ?? '')
                                            .trim()
                                            .toLowerCase() ==
                                        tab.toLowerCase();
                                  }).toList();

                            if (filteredPosts.isEmpty) {
                              return TabListBuilder(
                                uniquePageKey: tab,
                                length: 1,
                                builder: (context, index) => const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Center(
                                    child: Text("No posts in this category"),
                                  ),
                                ),
                              );
                            }

                            return TabListBuilder(
                              uniquePageKey: tab,
                              length: filteredPosts.length,
                              builder: (context, index) {
                                final post = filteredPosts[index];
                                final hasLocalImage =
                                    post.imagePath != null &&
                                    post.imagePath!.isNotEmpty;

                                final imageToShow = hasLocalImage
                                    ? post.imagePath!
                                    : (VideoUtils.getYoutubeThumbnail(
                                            post.videoUrl,
                                          ) ??
                                          Assets.postImage);

                                return GestureDetector(
                                  onTap: () {
                                    context.push(
                                      RouteConstants.postDetailsPage,
                                      extra: post,
                                    );
                                  },
                                  child: PostWidget(
                                    post: post,
                                    image: imageToShow,
                                    postName: post.heading ?? text.txtHeading,
                                    username:
                                        post.username ??
                                        currentUsername ??
                                        text.txtUsername,
                                    userImage: userImage,
                                    description:
                                        post.description ?? text.txtDescription,
                                    isLocalImage: hasLocalImage,
                                    isVideo:
                                        post.videoUrl != null &&
                                        post.videoUrl!.isNotEmpty,
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
