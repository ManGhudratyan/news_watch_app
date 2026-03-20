import 'package:flutter/material.dart';
import 'package:news_watch_app/presentation/constants/constants.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';

class DividerWithText extends StatelessWidget {
  final String text;

  const DividerWithText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: Divider(thickness: Constants.dividierThickness)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Gaps.medium),
          child: Text(text),
        ),
        Flexible(child: Divider(thickness: Constants.dividierThickness)),
      ],
    );
  }
}
