import 'package:flutter/material.dart';

class SliderWidget extends StatelessWidget {
  const SliderWidget({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.isLogout,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final bool? isLogout;

  @override
  Widget build(BuildContext context) {
    final isLogoutValue = isLogout ?? false;

    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      leading: Icon(icon, color: isLogoutValue ? Colors.red : Colors.black87),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: isLogoutValue ? Colors.red : Colors.black87,
        ),
      ),
      tileColor: Colors.grey.shade100,
      onTap: onTap,
    );
  }
}
