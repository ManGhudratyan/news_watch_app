import 'package:flutter/material.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';

class PostElementsWidget extends StatelessWidget {
  const PostElementsWidget({
    super.key,
    required this.title,
    required this.controller,
  });
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.grey),
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding: EdgeInsets.symmetric(
          vertical: Gaps.large,
          horizontal: Gaps.medium,
        ),
        hintText: title,
      ),
    );
  }
}
