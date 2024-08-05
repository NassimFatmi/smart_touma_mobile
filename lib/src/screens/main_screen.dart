import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_touma_mobile/src/screens/categories/categories_screen.dart';
import 'package:smart_touma_mobile/src/screens/home/home_screen.dart';
import 'package:smart_touma_mobile/src/screens/profile/profile_screen.dart';
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            label: 'Categories',
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
        children: [
          const HomeScreen(),
          const CategoriesScreen(),
          ProfileScreen(),
        ],
      ),
    );
  }
}
