import 'package:flutter/material.dart';

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
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        hintText: title,
      ),
    );
  }
}
