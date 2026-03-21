import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   leading: Row(
      //     children: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
      //   ),
      // ),
      body: Center(child: Text('Home page')),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        
        selectedItemColor: Colors.blue,
        unselectedItemColor: const Color.fromARGB(255, 124, 138, 145),
        backgroundColor: Colors.grey,
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          const BottomNavigationBarItem(icon: Icon(Icons.poll), label: 'Poll'),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined, size: 32, color: Colors.blue),
            label: 'Add Post',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
