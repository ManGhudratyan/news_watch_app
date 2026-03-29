// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/cubits/add_post/cubit/add_post_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/presentation/constants/assets.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';
import 'package:news_watch_app/presentation/pages/city_page.dart';
import 'package:news_watch_app/presentation/pages/posts/widgets/post_widget.dart';
import 'package:tabbed_sliverlist/tabbed_sliverlist.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        if (authState is! UserLoaded) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final currentUsername = authState.user.username;
        final userImage = authState.user.imagePath?.isNotEmpty == true
            ? authState.user.imagePath!
            : Assets.userImage;
        return Scaffold(
          appBar: AppBar(
            leading: const Icon(Icons.menu),
            title: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CityPage()),
                );
              },
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.red),
                  const SizedBox(width: 8),
                  Text(
                    authState.user.userCity?.isNotEmpty == true
                        ? authState.user.userCity!
                        : 'Select your city...',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
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
                  children: const [
                    Icon(Icons.stars_sharp, color: Colors.yellow),
                    SizedBox(width: 4),
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
          body: BlocBuilder<AddPostCubit, AddPostState>(
            builder: (context, state) {
              if (state.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              final posts = state.posts ?? [];
              return TabbedList(
                tabLength: tabs.length,
                sliverTabBar: SliverTabBar(
                  title: const SizedBox.shrink(),
                  expandedHeight: kToolbarHeight,
                  tabBar: TabBar(
                    isScrollable: true,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 6),
                    indicatorPadding: EdgeInsets.zero,
                    tabs: tabs.map((tab) => Tab(text: tab)).toList(),
                  ),
                ),
                tabLists: tabs.map((tab) {
                  if (tab == 'All') {
                    if (posts.isEmpty) {
                      return TabListBuilder(
                        uniquePageKey: tab,
                        length: 1,
                        builder: (context, index) => const Padding(
                          padding: EdgeInsets.all(20),
                          child: Center(child: Text("No posts yet")),
                        ),
                      );
                    }
                    return TabListBuilder(
                      uniquePageKey: tab,
                      length: posts.length,
                      builder: (context, index) {
                        final post = posts[index];
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
                            image: post.imagePath ?? Assets.postImage,
                            postName: post.heading,
                            username: post.username ?? currentUsername,
                            userImage: userImage,
                            description: post.description,
                          ),
                        );
                      },
                    );
                  } else {
                    return TabListBuilder(
                      uniquePageKey: tab,
                      length: 1,
                      builder: (context, index) => const Padding(
                        padding: EdgeInsets.all(20),
                        child: Center(child: Text("No posts in this category")),
                      ),
                    );
                  }
                }).toList(),
              );
            },
          ),
        );
      },
    );
  }
}
