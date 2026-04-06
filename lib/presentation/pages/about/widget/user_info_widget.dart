import 'package:flutter/material.dart';
import 'package:news_watch_app/presentation/constants/gaps.dart';

class UserInfoWidget extends StatelessWidget {
  const UserInfoWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });
  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: Gaps.large,
          backgroundColor: const Color.fromARGB(255, 195, 193, 193),
          child: Icon(
            icon,
            color: Color.fromARGB(219, 165, 129, 123),
            size: 20,
          ),
        ),
        SizedBox(width: Gaps.medium),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w200),
          ),
        ),
        Text(value, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
