import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:news_watch_app/core/routes/route_constants.dart';
import 'package:news_watch_app/presentation/constants/assets.dart';
import 'package:news_watch_app/presentation/constants/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      // Navigator.pushNamed(context, RouteConstants.signUpPage);
      context.push(RouteConstants.signUpPage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(Assets.newsWatch),
            SizedBox(height: Constants.sizedBoxSize),
            Text(
              'All type of new from all trusted sources for all\n types of people',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
