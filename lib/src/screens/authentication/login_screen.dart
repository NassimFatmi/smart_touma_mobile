import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smart_touma_mobile/src/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthService _authService = AuthService();

  void _loginWithGoogle() async {
    final userCredentials = await _authService.signInWithGoogle();
    print(userCredentials);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Login Screen'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _loginWithGoogle,
              icon: const FaIcon(FontAwesomeIcons.google),
              label: const Text('Login With Google'),
            ),
          ],
        ),
      ),
    );
  }
}
