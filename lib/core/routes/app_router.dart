import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/data/models/post/post_model.dart';
import 'package:news_watch_app/presentation/pages/about/screens/about_page.dart';
import 'package:news_watch_app/presentation/pages/auth/screens/forgot_password_page.dart';
import 'package:news_watch_app/presentation/pages/auth/screens/sign_in_page.dart';
import 'package:news_watch_app/presentation/pages/auth/screens/sign_up_page.dart';
import 'package:news_watch_app/presentation/pages/main/screens/city_page.dart';
import 'package:news_watch_app/presentation/pages/main/screens/home_page.dart';
import 'package:news_watch_app/presentation/pages/main/screens/main_page.dart';
import 'package:news_watch_app/presentation/pages/main/screens/profile_page.dart';
import 'package:news_watch_app/presentation/pages/main/screens/settings_page.dart';
import 'package:news_watch_app/presentation/pages/main/screens/splash_screen.dart';
import 'package:news_watch_app/presentation/pages/posts/screens/add_post_page.dart';
import 'package:news_watch_app/presentation/pages/posts/screens/post_details_page.dart';
import 'package:news_watch_app/presentation/pages/posts/screens/saved_posts_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteConstants.initialRoute,
    routes: [
      GoRoute(
        path: RouteConstants.initialRoute,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteConstants.mainPage,
        builder: (context, state) => const MainPage(),
      ),
      GoRoute(
        path: RouteConstants.signInPage,
        builder: (context, state) => const SignInPage(),
      ),
      GoRoute(
        path: RouteConstants.signUpPage,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: RouteConstants.homePage,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: RouteConstants.forgotPasswordPage,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: RouteConstants.settingsPage,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: RouteConstants.profilePage,
        builder: (context, state) => const ProfilePage(),
      ),
      GoRoute(
        path: RouteConstants.addPostPage,
        builder: (context, state) => const AddPostPage(),
      ),
      GoRoute(
        path: RouteConstants.cityPage,
        builder: (context, state) => const CityPage(),
      ),
      GoRoute(
        path: RouteConstants.aboutPage,
        builder: (context, state) => const AboutPage(),
      ),
      GoRoute(
        path: RouteConstants.savedPostsPage,
        builder: (context, state) => const SavedPostsPage(),
      ),
      GoRoute(
        path: RouteConstants.postDetailsPage,
        builder: (context, state) {
          final post = state.extra as PostModel;
          return PostDetailsPage(post: post);
        },
      ),
    ],
    errorBuilder: (context, state) =>
        const Scaffold(body: Center(child: Text('Page not found'))),
  );
}
