import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_touma_mobile/src/providers.dart';
import 'package:smart_touma_mobile/src/routes.dart';
import 'package:smart_touma_mobile/src/wrapper.dart';
import 'package:smart_touma_mobile/theme/app_theme.dart';

class SmartToumaApp extends StatelessWidget {
  const SmartToumaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.providers,
      child: MaterialApp(
        title: 'Flutter Mobile Application',
        theme: AppTheme.themeData,
        home: const Wrapper(),
        routes: Routes.routes,
      ),
    );
  }
}
