import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 80, color: Colors.grey),
            SizedBox(height: 20),
            Text(
              "No Internet Connection",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Please check your Wi-Fi or mobile data",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}