// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/cubits/add_post/cubit/add_post_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/data/repositories/add_post_repository_imp.dart';
import 'package:news_watch_app/data/repositories/user_repository_imp.dart';
import 'package:news_watch_app/presentation/pages/posts/pages/add_post_page.dart';
import 'package:news_watch_app/presentation/pages/main/home_page.dart';
import 'package:news_watch_app/presentation/pages/main/poll_page.dart';
import 'package:news_watch_app/presentation/pages/main/profile_page.dart';
import 'package:news_watch_app/presentation/pages/main/settings_page.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PersistentTabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<AuthCubit>(
        //   create: (_) => AuthCubit(UserRepositoryImp())..add(GetUserEvent()),
        // ),
        // BlocProvider<AddPostCubit>(
        //   create: (_) => AddPostCubit(addPostRepository: AddPostRepositoryImp()),
        // ),
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(UserRepositoryImp())..getUser(),
        ),
        BlocProvider<AddPostCubit>(
          create: (_) => AddPostCubit(AddPostRepositoryImp()),
        ),
      ],
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, authState) {
          if (authState is UserLoaded) {
            context.read<AddPostCubit>().getPosts(authState.user.userId!);
          }
        },
        child: PersistentTabView(
          context,
          controller: _controller,
          screens: const [
            HomePage(),
            PollPage(),
            AddPostPage(),
            SettingsPage(),
            ProfilePage(),
          ],
          items: [
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.home, size: 24),
              title: "Home",
              activeColorPrimary: Colors.blue,
              inactiveColorPrimary: Colors.grey,
              textStyle: const TextStyle(fontSize: 10, height: 1.0),
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.poll, size: 24),
              title: "Poll",
              activeColorPrimary: Colors.blue,
              inactiveColorPrimary: Colors.grey,
              textStyle: const TextStyle(fontSize: 10, height: 1.0),
            ),
            PersistentBottomNavBarItem(
              icon: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 6,
                    ),
                  ],
                ),
                child: const Icon(Icons.add, color: Colors.white, size: 36),
              ),
              title: "",
              activeColorPrimary: Colors.transparent,
              inactiveColorPrimary: Colors.transparent,
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.settings, size: 24),
              title: "Settings",
              activeColorPrimary: Colors.blue,
              inactiveColorPrimary: Colors.grey,
              textStyle: const TextStyle(fontSize: 10, height: 1.0),
            ),
            PersistentBottomNavBarItem(
              icon: const Icon(Icons.supervised_user_circle, size: 24),
              title: "Profile",
              activeColorPrimary: Colors.blue,
              inactiveColorPrimary: Colors.grey,
              textStyle: const TextStyle(fontSize: 10, height: 1.0),
            ),
          ],
          navBarStyle: NavBarStyle.style15,
          backgroundColor: Colors.grey[200]!,
          confineToSafeArea: true,
          navBarHeight: 55,
          onItemSelected: (index) {
            if (index == 2) {
              _controller.jumpToTab(2);
            }
          },
        ),
      ),
    );
  }
}
