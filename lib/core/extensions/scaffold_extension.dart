import 'package:flutter/material.dart';

extension ScaffoldMessengerExtension on BuildContext {
  void showSnackBarMessage(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }
}
