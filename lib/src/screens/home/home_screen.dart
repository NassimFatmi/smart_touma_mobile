import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_touma_mobile/src/services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AuthService _authService = AuthService();

  int selectedIndex = 0;

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void logout() async {
    await _authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: logout,
        child: const FaIcon(FontAwesomeIcons.rightFromBracket),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.house,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.gear,
            ),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.userGear,
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: const [
          Center(
            child: Text('Home Screen'),
          ),
          Center(
            child: Text('Settings Screen'),
          ),
          Center(
            child: Text('Profile Screen'),
          ),
        ],
      ),
    );
  }
}
