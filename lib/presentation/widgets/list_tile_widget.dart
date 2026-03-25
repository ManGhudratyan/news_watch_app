import 'package:flutter/material.dart';
import 'package:news_watch_app/presentation/constants/constants.dart';

class ListTileWidget extends StatelessWidget {
  const ListTileWidget({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });
  final String title;
  final Icon icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: icon,
          trailing: Icon(Icons.chevron_right_outlined),
          onTap: onTap,
        ),
        Divider(thickness: Constants.dividierThickness),
      ],
    );
  }
}
