import 'package:flutter/material.dart';

class PollPage extends StatefulWidget {
  const PollPage({super.key});

  @override
  State<PollPage> createState() => _PollPageState();
}

class _PollPageState extends State<PollPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Poll page')));
  }
}
