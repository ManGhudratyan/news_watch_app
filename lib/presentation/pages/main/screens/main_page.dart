// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/cubits/add_post/cubit/add_post_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_cubit.dart';
import 'package:news_watch_app/cubits/auth/cubit/auth_state.dart';
import 'package:news_watch_app/cubits/connectivity/connectivity_cubit.dart';
import 'package:news_watch_app/presentation/constants/assets.dart';
import 'package:news_watch_app/presentation/pages/main/screens/home_page.dart';
import 'package:news_watch_app/presentation/pages/main/screens/profile_page.dart';
import 'package:news_watch_app/presentation/pages/main/screens/settings_page.dart';
import 'package:news_watch_app/presentation/pages/main/screens/video_page.dart';
import 'package:news_watch_app/presentation/pages/posts/screens/add_post_page.dart';
import 'package:news_watch_app/presentation/widgets/no_interner_widget.dart';
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
      VideoPage(),
      AddPostPage(),
      SettingsPage(),
      ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(String? imagePath) {
    const activeColor = Color(0xFF1976D2);
    const inactiveColor = Color.fromARGB(255, 158, 158, 158);

    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home_rounded, size: 24),
        inactiveIcon: const Icon(Icons.home_outlined, size: 24),
        title: "Home",
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
        textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.ondemand_video_rounded, size: 24),
        inactiveIcon: const Icon(Icons.ondemand_video_outlined, size: 24),
        title: "Video",
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
        textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFF42A5F5), Color(0xFF1976D2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: Colors.white, width: 4),
            boxShadow: const [
              BoxShadow(
                color: Color(0x331976D2),
                blurRadius: 14,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
        title: "",
        activeColorPrimary: Colors.transparent,
        inactiveColorPrimary: Colors.transparent,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings_rounded, size: 24),
        inactiveIcon: const Icon(Icons.settings_outlined, size: 24),
        title: "Settings",
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
        textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: activeColor, width: 1.6),
          ),
          child: CircleAvatar(
            radius: 13,
            backgroundColor: Colors.grey.shade200,
            child: CircleAvatar(
              radius: 11,
              backgroundImage: imagePath != null && imagePath.isNotEmpty
                  ? FileImage(File(imagePath))
                  : AssetImage(Assets.userImage) as ImageProvider,
            ),
          ),
        ),
        title: "Profile",
        activeColorPrimary: activeColor,
        inactiveColorPrimary: inactiveColor,
        textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
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

        return BlocBuilder<ConnectivityCubit, ConnectivityState>(
          builder: (context, state) {
            if (state is ConnectivityDisconnected) {
              return NoInternetWidget();
            }

            return PersistentTabView(
              context,
              controller: _controller,
              screens: _buildScreens(),
              items: _navBarsItems(imagePath),
              navBarStyle: NavBarStyle.style15,
              backgroundColor: Colors.white,
              decoration: NavBarDecoration(
                borderRadius: BorderRadius.circular(22),
                colorBehindNavBar: const Color(0xFFF5F7FB),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 18,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              confineToSafeArea: true,
              navBarHeight: 68,
              margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: true,
              stateManagement: true,
              onItemSelected: (index) {
                _controller.jumpToTab(index);
              },
            );
          },
        );
      },
    );
  }
}
