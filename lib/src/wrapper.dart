import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_touma_mobile/src/screens/authentication/login_screen.dart';
import 'package:smart_touma_mobile/src/screens/main_screen.dart';
import 'package:smart_touma_mobile/src/screens/utils/loading_screen.dart';

class Wrapper extends StatelessWidget {
  Wrapper({super.key});

  final FirebaseAuth _instance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasData) {
            final User? user = snapshot.data;
            return FutureBuilder(
              future: user?.getIdToken(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const LoadingScreen();
                } else {
                  return const MainScreen();
                }
              },
            );
          } else {
            return const LoginScreen();
          }
        });
  }
}
