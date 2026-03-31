import 'package:flutter/material.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/data/models/add_post/add_post_model.dart';
import 'package:news_watch_app/presentation/pages/auth/screens/forgot_password_page.dart';
import 'package:news_watch_app/presentation/pages/auth/screens/sign_up_page.dart';
import 'package:news_watch_app/presentation/pages/main/city_page.dart';
import 'package:news_watch_app/presentation/pages/posts/pages/add_post_page.dart';
import 'package:news_watch_app/presentation/pages/main/home_page.dart';
import 'package:news_watch_app/presentation/pages/posts/pages/post_details_page.dart';
import 'package:news_watch_app/presentation/pages/main_page.dart';
import 'package:news_watch_app/presentation/pages/main/profile_page.dart';
import 'package:news_watch_app/presentation/pages/main/settings_page.dart';
import 'package:news_watch_app/presentation/pages/auth/screens/sign_in_page.dart';
import 'package:news_watch_app/presentation/pages/splash_screen.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.initialRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RouteConstants.mainPage:
        return MaterialPageRoute(builder: (_) => const MainPage());
      case RouteConstants.signInPage:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case RouteConstants.signUpPage:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case RouteConstants.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RouteConstants.forgotPasswordPage:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      case RouteConstants.settingsPage:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case RouteConstants.profilePage:
        return MaterialPageRoute(builder: (_) => const ProfilePage());
      case RouteConstants.addPostPage:
        return MaterialPageRoute(builder: (_) => const AddPostPage());
      case RouteConstants.cityPage:
        return MaterialPageRoute(builder: (_) => const CityPage());
      case RouteConstants.postDetailsPage:
        final post = settings.arguments as AddPostModel;
        return MaterialPageRoute(builder: (_) => PostDetailsPage(post: post));
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
