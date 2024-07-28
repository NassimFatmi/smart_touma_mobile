import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_touma_mobile/src/providers/auth_provider.dart';

class Providers {
  Providers._();
  static final List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider<AuthProvider>(
      create: (BuildContext context) => AuthProvider(),
    ),
  ].toList();
}
