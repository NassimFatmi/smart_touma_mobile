import 'dart:convert';

import 'package:smart_touma_mobile/src/constants/api_config.dart';
import 'package:smart_touma_mobile/src/models/document_category_model.dart';
import 'package:http/http.dart' as http;

class CategoriesService {
  Future<List<DocumentCategory>?> getCategories(String? token) async {
    try {
      final response = await http
          .get(Uri.parse('${ApiConfig.baseUrl}/categories'), headers: {
        'x-api-key': ApiConfig.apiKey,
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body);

        final List<DocumentCategory> categories = result
            .map((category) => DocumentCategory.fromJson(category))
            .toList();
        return categories;
      } else {
        throw Exception('Failed to load home data');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to load home data');
    }
  }

  Future<DocumentCategory> createCategory(
    String? token,
    String name,
    String description,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConfig.baseUrl}/categories'),
        headers: {
          'x-api-key': ApiConfig.apiKey,
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': name,
          'description': description,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        return DocumentCategory.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to create category');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to create category');
    }
  }

  Future<DocumentCategory> updateCategory(
    String? token,
    DocumentCategory category,
  ) async {
    try {
      final response = await http.put(
        Uri.parse('${ApiConfig.baseUrl}/categories/${category.id}'),
        headers: {
          'x-api-key': ApiConfig.apiKey,
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'name': category.name,
          'description': category.description,
        }),
      );

      if (response.statusCode == 200) {
        return category.copyWith(
          name: category.name,
          description: category.description,
        );
      } else {
        throw Exception('Failed to update category');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to update category');
    }
  }

  Future<void> deleteCategory(String? token, String id) async {
    try {
      final response = await http.delete(
        Uri.parse('${ApiConfig.baseUrl}/categories/$id'),
        headers: {
          'x-api-key': ApiConfig.apiKey,
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to delete category');
      }
    } catch (e) {
      print(e);
      throw Exception('Failed to delete category');
    }
  }
}
