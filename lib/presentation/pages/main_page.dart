// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/cubits/add_post/cubit/add_post_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
import 'package:news_watch_app/presentation/constants/assets.dart';
import 'package:news_watch_app/presentation/pages/main/home_page.dart';
import 'package:news_watch_app/presentation/pages/main/profile_page.dart';
import 'package:news_watch_app/presentation/pages/main/settings_page.dart';
import 'package:news_watch_app/presentation/pages/posts/pages/add_post_page.dart';
import 'package:news_watch_app/presentation/pages/posts/pages/add_video_page.dart';
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

  List<Widget> _buildScreens() {
    return const [
      HomePage(),
      AddVideoPage(),
      AddPostPage(),
      SettingsPage(),
      ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(String? imagePath) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home, size: 24),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        textStyle: const TextStyle(fontSize: 10, height: 0.8),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.video_collection_outlined, size: 24),
        title: "Video",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        textStyle: const TextStyle(fontSize: 10, height: 0.8),
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 6),
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
        textStyle: const TextStyle(fontSize: 10, height: 0.8),
      ),
      PersistentBottomNavBarItem(
        icon: CircleAvatar(
          radius: 13,
          child: CircleAvatar(
            radius: 11,
            backgroundImage: imagePath != null && imagePath.isNotEmpty
                ? FileImage(File(imagePath))
                : AssetImage(Assets.userImage) as ImageProvider,
          ),
        ),
        title: "Profile",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        textStyle: const TextStyle(fontSize: 10, height: 0.8),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, authState) {
        if (authState.user?.userId != null) {
          context.read<AddPostCubit>().getPosts(authState.user!.userId!);
        }
      },
      builder: (context, authState) {
        final imagePath = authState.user?.imagePath;

        return PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(imagePath),
          navBarStyle: NavBarStyle.style15,
          backgroundColor: Colors.grey[200]!,
          confineToSafeArea: true,
          navBarHeight: 55,
          onItemSelected: (index) {
            _controller.jumpToTab(index);
          },
        );
      },
    );
  }
}
