// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_watch_app/data/repositories/add_post_repository_imp.dart';
import 'package:news_watch_app/data/repositories/user_repository_imp.dart';
import 'package:news_watch_app/presentation/pages/auth/logic/user_bloc.dart';
import 'package:news_watch_app/presentation/pages/posts/logic/add_post_bloc.dart';
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

  List<Widget> _buildScreens() {
    return const [
      HomePage(),
      PollPage(),
      AddPostPage(),
      SettingsPage(),
      ProfilePage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.poll),
        title: "Poll",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 8),
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
        icon: const Icon(Icons.settings),
        title: "Settings",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.supervised_user_circle),
        title: "Profile",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (_) => UserBloc(UserRepositoryImp())..add(GetUserEvent()),
        ),
        BlocProvider<AddPostBloc>(
          create: (_) => AddPostBloc(addPostRepository: AddPostRepositoryImp()),
        ),
      ],
      child: BlocListener<UserBloc, UserState>(
        listener: (context, userState) {
          if (userState is UserLoaded) {
            context.read<AddPostBloc>().add(
              GetPostsEvent(userId: userState.user.userId!),
            );
          }
        },
        child: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          navBarStyle: NavBarStyle.style15,
          backgroundColor: Colors.grey[200]!,
          confineToSafeArea: true,
          navBarHeight: 60,
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
