import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_touma_mobile/src/screens/home/home_screen.dart';
import 'package:smart_touma_mobile/src/services/auth_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
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
          HomeScreen(),
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
