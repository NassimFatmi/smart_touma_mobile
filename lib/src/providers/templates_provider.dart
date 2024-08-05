import 'package:flutter/material.dart';
import 'package:smart_touma_mobile/src/models/template_model.dart';

class TemplatesProvider extends ChangeNotifier {
  final _templates = <Template>[];

  List<Template> get templates => _templates;

  void addTemplate(Template template) {
    _templates.add(template);
    notifyListeners();
  }

  void removeTemplate(Template template) {
    _templates.remove(template);
    notifyListeners();
  }
}
