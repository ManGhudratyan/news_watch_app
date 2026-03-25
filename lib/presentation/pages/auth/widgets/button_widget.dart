import 'package:flutter/material.dart';
import 'package:news_watch_app/presentation/constants/constants.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.title, this.onPressed});

  final String title;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Constants.buttonSizedBoxWidth,
        height: Constants.buttonSizedBoxHeight,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 56, 178, 239),
          ),
          onPressed: onPressed,
          child: Text(title, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
