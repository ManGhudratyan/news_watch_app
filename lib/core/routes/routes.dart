import 'package:flutter/material.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/presentation/pages/forgot_password_page.dart';
import 'package:news_watch_app/presentation/pages/home_page.dart';
import 'package:news_watch_app/presentation/pages/sign_in_page.dart';
import 'package:news_watch_app/presentation/pages/sign_up_page.dart';

class Routes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.initialRoute:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      case RouteConstants.signInPage:
        return MaterialPageRoute(builder: (_) => const SignInPage());
      case RouteConstants.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case RouteConstants.forgotPasswordPage:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordPage());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
