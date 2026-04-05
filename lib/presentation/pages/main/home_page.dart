// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/cubits/add_post/cubit/add_post_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
import 'package:news_watch_app/presentation/constants/assets.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/pages/about/about_page.dart';
import 'package:news_watch_app/presentation/pages/auth/screens/forgot_password_page.dart';
import 'package:news_watch_app/presentation/pages/main/city_page.dart';
import 'package:news_watch_app/presentation/pages/posts/pages/saved_posts_page.dart';
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

  String? getYoutubeLinkContains(String? url) {
    if (url == null || url.isEmpty) return null;

    final uri = Uri.tryParse(url); // host, path,query parametr
    if (uri == null) return null;

    String? videoId;

    if (uri.host.contains('youtube.com')) {
      videoId = uri.queryParameters['v'];
    } else if (uri.host.contains('youtu.be')) {
      videoId = uri.pathSegments.isNotEmpty ? uri.pathSegments.first : null;
    }

    if (videoId == null || videoId.isEmpty) return null;

    return 'https://img.youtube.com/vi/$videoId/0.jpg';
  }

  @override
  Widget build(BuildContext context) {
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
                      const SizedBox(height: 12),
                      Text(
                        authState.user!.username,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        authState.user?.userCity ?? 'user city',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                  Divider(color: Colors.grey.shade300),
                  SliderWidget(
                    icon: Icons.location_on_outlined,
                    title: 'Change city',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CityPage()),
                      );
                    },
                  ),
                  SliderWidget(
                    icon: Icons.verified_user_outlined,
                    title: 'About page',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AboutPage()),
                      );
                    },
                  ),
                  SliderWidget(
                    icon: Icons.password_sharp,
                    title: 'Forgot password',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage(),
                        ),
                      );
                    },
                  ),
                  SliderWidget(
                    icon: Icons.bookmark_border_rounded,
                    title: 'Saved posts',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SavedPostsPage(),
                        ),
                      );
                    },
                  ),
                  Divider(color: Colors.grey.shade300),
                  const SizedBox(height: 10),
                  SliderWidget(
                    icon: Icons.logout,
                    title: 'Logout',
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CityPage(),
                                ),
                              );
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
                      builder: (context, state) {
                        if (state.loading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final posts = state.posts ?? [];

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
                                    : (getYoutubeLinkContains(post.videoUrl) ??
                                          Assets.postImage);

                                return GestureDetector(
                                  onTap: () {
                                    Navigator.of(
                                      context,
                                      rootNavigator: true,
                                    ).pushNamed(
                                      RouteConstants.postDetailsPage,
                                      arguments: post,
                                    );
                                  },
                                  child: PostWidget(
                                    image: imageToShow,
                                    postName: post.heading ?? 'heading',
                                    username:
                                        post.username ??
                                        currentUsername ??
                                        'username',
                                    userImage: userImage,
                                    description:
                                        post.description ?? 'description',
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
