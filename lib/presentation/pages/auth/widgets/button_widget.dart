import 'package:flutter/material.dart';
import 'package:news_watch_app/presentation/constants/constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor,
  });

  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Constants.buttonSizedBoxWidth,
        height: Constants.buttonSizedBoxHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? const Color(0xFF38B2EF),
          ),
          onPressed: onPressed,
          child: Text(title, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
