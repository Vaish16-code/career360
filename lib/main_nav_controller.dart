import 'package:flutter/material.dart';
import 'profile_page.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({super.key});

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  int _selectedIndex = 4; // Start with Profile tab
  final List<Widget> _pages = [
    const Center(child: Text("Home Page")),
    const Center(child: Text("Games Page")),
    const Center(child: Text("Careers Page")),
    const Center(child: Text("Mentors Page")),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: "Games",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: "Careers"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "Mentors"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
