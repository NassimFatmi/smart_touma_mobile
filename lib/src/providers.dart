import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_touma_mobile/src/providers/categories_provider.dart';
import 'package:smart_touma_mobile/src/providers/documents_provider.dart';
import 'package:smart_touma_mobile/src/providers/home_provider.dart';
import 'package:smart_touma_mobile/src/providers/templates_provider.dart';

class Providers {
  Providers._();
  static final List<ChangeNotifierProvider> providers = [
    ChangeNotifierProvider<CategoriesProvider>(
      create: (BuildContext context) => CategoriesProvider(),
    ),
    ChangeNotifierProvider<HomeProvider>(
      create: (BuildContext context) => HomeProvider(),
    ),
    ChangeNotifierProvider<DocumentsProvider>(
        create: (BuildContext context) => DocumentsProvider()),
    ChangeNotifierProvider<TemplatesProvider>(
        create: (BuildContext context) => TemplatesProvider()),
  ].toList();
}
