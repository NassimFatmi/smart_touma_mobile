import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_touma_mobile/src/providers.dart';
import 'package:smart_touma_mobile/src/routes.dart';
import 'package:smart_touma_mobile/src/wrapper.dart';

class SmartToumaApp extends StatelessWidget {
  const SmartToumaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.providers,
      child: MaterialApp(
        themeMode: ThemeMode.system,
        debugShowCheckedModeBanner: false,
        title: 'Smart Touma',
        home: Wrapper(),
        routes: Routes.routes,
        theme: ThemeData(useMaterial3: true),
      ),
    );
  }
}
