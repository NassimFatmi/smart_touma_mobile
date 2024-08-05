import 'package:flutter/material.dart';
import 'package:smart_touma_mobile/src/models/document_category_model.dart';
import 'package:smart_touma_mobile/src/services/auth_service.dart';
import 'package:smart_touma_mobile/src/services/categories_service.dart';

class CategoriesProvider with ChangeNotifier {
  final CategoriesService _categoriesService = CategoriesService();
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<DocumentCategory> _categories = [];

  List<DocumentCategory> get categories => _categories;

  String? _error;

  String? get error => _error;

  void deleteError() {
    _error = null;
    notifyListeners();
  }

  Future<void> fetchCategories() async {
    try {
      _isLoading = true;
      notifyListeners();

      final currentUser = AuthService.instance.currentUser;
      final String? token = await currentUser?.getIdToken();

      final List<DocumentCategory>? categories =
          await _categoriesService.getCategories(token);

      if (categories != null) _categories = categories;
    } catch (e) {
      _error = e.toString();
    }
    _isLoading = false;
    notifyListeners();
  }

  set categories(List<DocumentCategory> value) {
    _categories = value;
    notifyListeners();
  }

  void addCategory(DocumentCategory category) {
    _categories.add(category);
    notifyListeners();
  }

  void removeCategory(DocumentCategory category) {
    _categories.remove(category);
    notifyListeners();
  }

  Future<void> updateCategory(DocumentCategory category) async {
    try {
      final currentUser = AuthService.instance.currentUser;
      final String? token = await currentUser?.getIdToken();

      final DocumentCategory updatedCategory =
          await _categoriesService.updateCategory(token, category);

      final index = _categories.indexWhere((c) => c.id == updatedCategory.id);
      _categories[index] = updatedCategory;
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  Future<void> deleteCategory(DocumentCategory category) async {
    try {
      final currentUser = AuthService.instance.currentUser;
      final String? token = await currentUser?.getIdToken();

      await _categoriesService.deleteCategory(token, category.id);
      _categories.remove(category);
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }

  Future<void> createCategory({
    required String name,
    required String description,
  }) async {
    try {
      final currentUser = AuthService.instance.currentUser;
      final String? token = await currentUser?.getIdToken();

      final DocumentCategory category = await _categoriesService.createCategory(
        token,
        name,
        description,
      );

      _categories.add(category);
    } catch (e) {
      _error = e.toString();
    }
    notifyListeners();
  }
}
